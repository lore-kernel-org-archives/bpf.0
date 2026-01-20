Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2D3E9F68
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949533; cv=none; b=ITbPQcPsh/oCurBmFXE2kUrjA/3CAOUtC2zNzIu8wdxE8UwysIOSNJutJQGuEUASvTbGQ63ugyZchp03wFv+BCEcmGz6/FuuAvNpRwVgVoiYzQgYBwZDmbo0iB3mDZ7CFk1tcC/pXzdcBHjyi2d4GutsaXR4bNzOqMxftW0W0w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949533; c=relaxed/simple;
	bh=B+4SQN3XtEYLxLN4jI2aCDpcYoyy+NMRu6RK31oqMIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgAHImWKWLLiGcgegstOGnSH53j0zZAYF6/vc9BFXwmTuDLXgCajGIGvRq9FpEP2huunWo6oEi4VvjYACjsrcgqhtN31gxs+JZ26wjn7H9qMO1S7p2T77AyDANW+m45k0aAol0mpuxfEcSsIxG419A0AcxKLrhQ1Oxl+YBSILsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jpkHTjD+; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jpkHTjD+"
Message-ID: <0c8f3058-6c7c-43e9-a1c6-378622df6373@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768949528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+4SQN3XtEYLxLN4jI2aCDpcYoyy+NMRu6RK31oqMIg=;
	b=jpkHTjD+ZmTaAX3Op8MVW3gsbHdjoKPksAzEe06Regyr9ER+rgRcOiKJFQOKRjTfFVbBEj
	5bG5ykg24L3dvD7mUDULxQQjDEqKV5vw92jWuDMJwGSQXel7rNxgQDgF613p2dsoo995EN
	XqgFLenF6A+xRSBh88yuW4EOZMJWF6E=
Date: Tue, 20 Jan 2026 14:52:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: test bpf_get_func_arg()
 for tp_btf
Content-Language: en-GB
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260120073046.324342-1-dongml2@chinatelecom.cn>
 <20260120073046.324342-3-dongml2@chinatelecom.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260120073046.324342-3-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/19/26 11:30 PM, Menglong Dong wrote:
> Test bpf_get_func_arg() and bpf_get_func_arg_cnt() for tp_btf. The code
> is most copied from test1 and test2.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

