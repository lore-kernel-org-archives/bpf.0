Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68240B6D7;
	Tue, 20 Jan 2026 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952736; cv=none; b=eyrOEPn19GPjgmsd3UkTpXQyUmUkF/BW+Kh+dF81D0iPfAolDSPSQtE4Y8DAs7hCtKjE1ytw+EO7VJVzL4zvGKqIW09qJYOOUJVvC+W+CRBQ21dONx0zfowArwJLXlNdTrHGM9/5lYrqj9p+P05mpurXcdb9cD/q+UO2HzJNQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952736; c=relaxed/simple;
	bh=jL/7vVA+gUsv4xHRbAo6D2qtk34WOY1sRirNHheUR38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYwfgp9H5sEFbRolKcSHCVuFCqqZdWHMYX+psCl+zJJAFYPRQS/NZD+h9u6LWLnnpAicGHgoPcz1OR0985P5uUCma/KyDQVwnsbSY+RlxNY3Td0Y12igNTRquTS0/cXER8QMavLvRjxOb6bn9AwdNVUAAQ1fODFcAfd+/lE7f5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RNZkVOrw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RNZkVOrw"
Message-ID: <7feb07c9-7fa9-4c0f-96cd-c7866b0653dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768952729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lt9/+gpkMS0VzHPk6kzxJIsqzLidRTxkoRLv481rJDE=;
	b=RNZkVOrwr/xbIcGuhUb3MACA/tRj7GoNWDPROpai/8wKNQVdEniJ8/e/TJ3aQviqSkcgtM
	Z3ZjgkTX5NaOYSkp1p5JbOWigA7rR9ZbxQi3Fg05zS07WBaXwraFpEVjtsCUjbRMMtLuqH
	H44Gnk82qHKb35N/vjCFYQ0tTp/CXTE=
Date: Tue, 20 Jan 2026 15:45:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] bpf: net_sched: Use direct helper calls
 instead of kfuncs in pro/epilogue
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, bpf@vger.kernel.org
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-2-e8b88d6430d8@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-2-e8b88d6430d8@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/19/26 11:53 AM, Jakub Sitnicki wrote:
> Convert bpf_qdisc prologue and epilogue to use BPF_EMIT_CALL for direct
> helper calls instead of BPF_CALL_KFUNC.
> 
> Remove the BTF_ID_LIST entries for these functions since they are no longer
> registered as kfuncs.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

