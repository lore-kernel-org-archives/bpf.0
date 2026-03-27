Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237A3BF685;
	Fri, 27 Mar 2026 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593775; cv=none; b=CNOS8lLcWquVROKtXlY+a0QZTrpKTIYxJF/sYoG+vBS9r0cJGnyyax7YMTwacTHLyKZONKu8IhN3d7yPdIQ+IintY56+Ka87HfGw4Mc9DhJsNHCkXRIJEyc4TgXGIz2D9JAnUNiPkqNcH/jtbofc8SB/o1wW2FuxGnaZp5DwNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593775; c=relaxed/simple;
	bh=wFXmO27wKvV6/Kr+vvz+qry41MFFNZPIOZqFd6mwDpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFjOjF6RJ/ohEf+V65cHTjIsMz3znY9PhDtPWqWRu3fZt2D+MPV0598O5d1qnlsaT4PY2AZpumpq0Co2z2FVYoqHqU087CCy2aIiHhCqbwvzhGw4QDlL7Z/mV4pWmuVkzerlieXF5AuMOWOhGdQUtfVDjRRF46SE5Ws8zrVoEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BMHLiTTQ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BMHLiTTQ"
Message-ID: <785e0b04-91e4-457f-8d6c-e0a911c0fd88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774593754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b59W3l9WpyzX2iAsGdXQno8uo7jmzlLBBhaOtXWpNvk=;
	b=BMHLiTTQOLBNNQJP1khgYmCgNFAUY7dhRkrLHCZixLoDngy+y9oGHvb+X/htRg5tAnrzYL
	qjUTh78zj/13+gL/g6zuuaUcknueSbo/k9tL8No+U7yYTPc/n6xr65yrih1eE9EWSBHKov
	kZH7LA0auDo3Rmb8p0JFYlNF0BYBsEM=
Date: Fri, 27 Mar 2026 14:42:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with
 mismatched xdp_has_frags values
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-2-leon.hwang@linux.dev>
 <20260326124205.1a3bb825@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260326124205.1a3bb825@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/3/26 03:42, Jakub Kicinski wrote:
> On Tue, 24 Mar 2026 23:04:42 +0800 Leon Hwang wrote:
>> The commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
>> was to ensure backwards compatibility against tail calls. However, it
>> missed that XDP progs can be extended by freplace progs, which could break
>> the backwards compatibility, e.g. xdp_has_frags=true freplace progs are
>> allowed to attach to xdp_has_frags=false XDP progs.
>>
>> To avoid breaking the backwards compatibility via freplace, disallow
>> freplace on XDP programs with different xdp_has_frags values.
> 
> It may be worth adding a selftest to
> tools/testing/selftests/drivers/net/xdp.py
> which sets MTU to 9k, tries to attach a non-frag-capable prog
> if that fails attaches a frag-capable prog and then checks if
> replacing the capable prog with non-capable fails.
> Drivers may be buggy in this regard.

Do you mean adding these two tests to xdp.py?

1. Verify the failure of attaching non-frag-capable prog to mtu=9k
   driver.
2. Verify the failure of updating frag-capable prog with non-frag-
   capable prog via libbpf.c::bpf_link__update_program().

As for test #2, it may require a helper to attach prog then update prog
using libbpf's APIs.

Thanks,
Leon

