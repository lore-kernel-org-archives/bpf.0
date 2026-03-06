Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1ED36C59D
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813652; cv=pass; b=WBQpdktvSlN0hK8TdB9X1h7FFCn/9PsqkLI0/lO0qk19MJDlxMSr7xKEm6Zn+5BnrwfI+ndBEp8UTJvsXJPDAb4z210VjXqjgrPra4AAH1bhwzgrd89jS7JL+irfZy70eBPc996s+cVIBdBWAfVuf491OupTiD5OSenElJHfEHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813652; c=relaxed/simple;
	bh=/9Va/T23BhHUgRagFKsTIw8TxUls7NWQNPZou4M+b7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONQQdW9tOGTCa69tZB9NHxxapUk+3zHMSs4asNHcLJvCD8p1gEorLnehqK21D3kIQBEXwNW1VldJSbJuFN0Ough1KkUgVcIUWH5q8EVW5hye8wnuS+fnfjMoCps07R0ybavjLCnQ0xeyEVlNyABMXY1gouXGg/y/fZQ/sm5w+a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMm77mIe; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMm77mIe"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-439bcec8613so4218086f8f.3
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 08:14:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772813650; cv=none;
        d=google.com; s=arc-20240605;
        b=es+Pe7K2OAjttMdB6Fy2RJUsCNhQglzBa+YHmHHP0IRzirmfy359hh8+SIJi9CMSm9
         KWNMQ4DEir7elpzO0pcG0K633xg7Y0lfOCL2aCnKMmW6M5tkchevbACz2o3Elpjnlr8h
         CBU+MqIeHgq/Y78wLdhHvUQj6tmFe0I2QCizu1YnStzbKUnJGl6yArBvp2SGe+Mwz/lu
         lr3x8VzW5MHxDJw3bnCaBmqVGDmauTPJvTD0MH5kxh+dBMSG7rafVlszWErAarv5QYL9
         KZ+WTXPtUhkhmXsNBpqWkXgRM4CUnKU2KhpG8K79L+F9Bxs7o3i62fDZY5P+37AIpAYO
         NJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/9Va/T23BhHUgRagFKsTIw8TxUls7NWQNPZou4M+b7E=;
        fh=NTE3CgXhsJQhCFjLsoDxCfZc/0OsKIw8WG0v+NskoE4=;
        b=AWbrzjWnZSMhHJVUM6tDB5NQf57LVO3m69g/KYIIlVxkmY4xqrohlKm1sKVM9llgP4
         awsT7tgMjqUkkQevXfQ4ByGtn7VFsidaQ+SgHxPa5zjwCEGjImwlISmt6LD/et1UD9Kg
         GLZXkJKECCHCiO+BVtzAc85Dc7B+n4wlZicFaeBhJdWW8AI+wO/knJkhBxqnPDRnFnkh
         wmV5kKiFMIy1dPbOociTrCssHi/SmW3orpOfmqOKFHL5JZgeOnjdYMjUcFZYUXah1yc9
         lkcIHgdzeGwQNUfHxY8yA9EoZqNOy6A8ljQo1jkxxppDBkNZrK2TTAd8fqBd6nE4rxic
         5Afg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772813650; x=1773418450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/9Va/T23BhHUgRagFKsTIw8TxUls7NWQNPZou4M+b7E=;
        b=RMm77mIeluZ6Yl739Do1rAfXq0mdzP0Z5UI2ENp3C/78SDdj/2fUfm7VWxDBOcxyKI
         Qe5mnPJscWv/jre6BQOLZMqIZ3452xABYvxoKzhp2Xk5L7bf5fKgKiLRRxCpc8p9LCx5
         GMRDw06ETDiLcjBrLKCA0bmCcCRJ6qvf1TzSIi3u7bhhz00qmYdopvDaMe06e9smgrGb
         scObRgKPzFJb4buTzylJMkhqrtxtgPxv+nn6ef1qsXGrlodFMA7S+ljnmuhd6S7uQ2q8
         CRcDaMG2JMYZi77Rm3WJwVZIf1UJ+eyjn/UehZfQtcVm33M2VPrs4RUq4avHI53F/yi8
         8A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772813650; x=1773418450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9Va/T23BhHUgRagFKsTIw8TxUls7NWQNPZou4M+b7E=;
        b=Sdl+L3kAmYJ6RDfq2epdffCxbumFxqCdP2d/Is0YBMRdq9tPwyIVykAZCHIPv1k9il
         nP3lX2Yy5Z8tbbf+9Cz7K5Ydyj7ISi310h4lpCb0mYuHjPnRVtG71f4s8SB/dw0fHZiq
         JTet3xhRClMFvVPtFTTXAvZ8SlCdNS4/xUhJEN33BvnxzX++71oBLK8JoAh2zRk5iMSU
         HhB/vVClY1NhuoWny7d4kQ7Za9npt50YPNkIlhmdQuk+9FG7mGPDfYXfJ/A0D0PG6wyB
         kgkFBToSrlBypG96anojoUWV/3Tccy5lqXFGSFP3xMLof7xutG+sBtyR0OVIvedDl9nD
         fDWQ==
X-Gm-Message-State: AOJu0YzwWtp3+oOBh4ul2j1X6exBbq7d1YkN2Xu/DmoqT3rjWbB37Bmh
	6B4n27OoYkDr6ayJlM2i64XAEV7OHCuSrO0w5C7/gszno/Czen/4ASpv1qknwLwuQA+pJNf1Iq+
	UpXbhL4IINbxLK1w1xJOVawxMUtAHamo=
X-Gm-Gg: ATEYQzxGQWhbd7VgQlAKzNmCia0ZE43adbSC28fbotgYZ6VbIPXOMjosjhmIH3DqyO1
	Bo7yMexNvE9B1W9y2vs2Gs8J78vpty09Jt+urzl3fkcAcZXuKhsTGl8JN4ByiHpHyh9reV6qoQG
	ZOYFMtptjoIO70HNJqyQ3zvcdeVJZvfctkLlLkb+xnaP8d7CfJrSiWAWYDF3lyEAo1W5Te5cZ4S
	6TLGpIR3EE0znGgm4TZN/f+3k/aOjljDENcR+Btd2QWqmVsjIzbHN51de1/tAzqdsLxr6UTPIv9
	STGy4CfSR8sAR8AVOEXeLQZtlQIHC1kLzHmBHEPLt1LWeRsZfh4Qh5CfSYU=
X-Received: by 2002:a05:6000:25c4:b0:439:c1e2:9221 with SMTP id
 ffacd0b85a97d-439da86fa7emr4686912f8f.58.1772813649538; Fri, 06 Mar 2026
 08:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772804199.git.vmalik@redhat.com> <8ce28b8f962759f5177b4b426f4ab372775aeef2.1772804200.git.vmalik@redhat.com>
In-Reply-To: <8ce28b8f962759f5177b4b426f4ab372775aeef2.1772804200.git.vmalik@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 17:13:33 +0100
X-Gm-Features: AaiRm53ZFOYc9mM-MWazaKFt4o50dH_gWcvlDiQSExel3ruZCPW7UYJ-QxRSkw0
Message-ID: <CAP01T77f1kJXcuxT1Hs_Ke8pc8fcWWB-NZw0VpZh4xtEbj14tg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Move sleepable
 refcounted_kptr tests to syscalls
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, Leon Hwang <leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 14:50, Viktor Malik <vmalik@redhat.com> wrote:
>
> Now that sleepable programs are always enabled on syscalls, let
> refcounted_kptr tests use syscalls rather than bpf_testmod_test_read,
> which is not sleepable with error injection disabled.
>
> The tests just check that the verifier can handle usage of RCU locks in
> sleepable programs and never actually attach. So, the attachment target
> doesn't matter (as long as it is sleepable) and with syscalls, the tests
> pass on kernels with disabled error injection.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
