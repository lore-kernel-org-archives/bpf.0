Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059982;
	b=RlKcF2aWbFQ5FnC9DUQFpUViC/XkMzZ9GY2sftKHA4mCULmGArtzdg4kPAvwqZcVgO+R
	 GqdlpWqjDjqKAhTWoCLZcW/84DCesewqUUf0BoUdVr5EwZAADraajAr2qNyMoHLtABJw+
	 PQ5LhzWFxr2Kl5ScW6K5aq5x694yrExbkv//dmFpdOIfRfj71+n7RAu+HtTEl0mTDjTrx
	 YR0oTEntNroOmwls1L7aUYjhZ/JIPFNKlzp+UMU4HZtPwuhP7bs50t0GAjLTFDFblHOaU
	 2nDykzGP3fv3rBkLqkSJ0T5MtiZf5qOdIX++PCBeSookDpKCp7po1ebbPWJe6g6kkhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To;
	bh=k+MRSlQhzGoUGKY3YxCZuP6Ii8xmMxd6Dvx8py9gP1E=;
	b=Z7ujEY1mdSMdynTrS9+eKZ/1AWCHZSHfq4JG3D6eRbRv5J+y2CveO0kzNQtkpOqQLH2W
	 Ww52Ga5eHCw+pO3oajYB5gcKqJ9D/CHaCsyETwL37jcTkobQwbrwZ7O7/L2aXNVpQBsqd
	 GTARgm1cjY24Sijwvk8JY/bj7anchl7/kCxe8rz03cOeQ2QamsKqX5jzD+4ZfvbwTj+ul
	 dTmJChUm/3++6X+9SZeVv4if5e6ZMYq3Lwh3OH6Ks+xfSpqrxkfb7ifIUe2p2FH9BeEtq
	 Sg1YyN+6J83PcSyT0dWobLCrOr6PJIKbyeLpCB9JuOWK7452geJEZAdHl7bsMuWrd9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VoQbrbVL;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3681606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 00:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3681606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VoQbrbVL
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so1258799a12.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 17:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793059981; x=1793664781; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k+MRSlQhzGoUGKY3YxCZuP6Ii8xmMxd6Dvx8py9gP1E=;
        b=VoQbrbVLwiHm97e9TnHnWDGWxhcEnJoDvurECn0Htk2q1wpBDYab8mLTT/7PG6cbme
         O7FBOwyaLAQu4f7VlEa3D2/ztm/8YeL1vBQItbKhLOyWXHXVY5arUh3HLzK8borhq5gz
         4N4f7VzCuWPr5FjzvaDcNGdJdNsIHpG4AhnBoaTjS1NJm/jUMRtXlFwGxyLjSvyLU1h+
         eTtsrm6+y7QKDMx0psLAuttqFImjLGkfCQpj2akZnw8wej237XYzPTGZgQ5NMN2dzo18
         Crjlc+pAr74HXLPpTlqMxq02h4xDi7ijxAOluZO5FVdYOtzrrtwvSD+TDdgfscOmCGR3
         x7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793059981; x=1793664781;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k+MRSlQhzGoUGKY3YxCZuP6Ii8xmMxd6Dvx8py9gP1E=;
        b=oq+rjwzdtJ01xLsrqvXtlCCZ+Qm36VKqucyAYdzkk6weZrq62/NDXP7+5VNnU9DynL
         vJwGyZv6K1PNEZ39/FZYZHXh8lhaTMNJBXI02vUiVNiVfZh5Az0bR+rYFTFpZfz1Tqv8
         spfQRvNQPSOEXDSmzg8EHC3l/IyhX50dF0x7nTwZDOsEefeWnUaLDv11LYw4X6Y0DRtg
         BJXUazsw1et65srca30SI2UM9ZNB0iOWH9Fsm5jz0wFkN0+owIZISDNszwBxVPUKqgrc
         XVU3bSeGmxCLdLzTdaxYOcO+pOL0px+NLGQJwPWkf2hDWUFJvn0Fy9UoBc1AqF2J+7DU
         1fqA==
X-Gm-Message-State: AFq9FYIziaWroco5BokRkRMFUrYb0BWnIn7GwF9QiGnNZpQ7REyla4T6
	SlZlxj0XVGT4WT14pvuPu2vsn0dHKOAf+3HaGliRTaHlmnweKLsNOfSt
X-Gm-Gg: AYBFou0eYT7R9bqSn4We44VdneVdXBrZnpN8SiCY68oNPq8aiZPkDWSqBdSGwQdwe7x
	JTQUsodgDchnfR2LaO0ZLtXKFf5hFlicazlSF53DAGm1a8xIulFTVkPWrXaLXiUNGq+ujhr/0mT
	hVDpTqOUP4DkY8XZ75Es3eNHDavDyfCP4nWsXQJ4gPBWv9teSex8Jcp0o/Gmt1xr75YfM5spbeO
	4EgC9ouuBYwGgFC+UbGoiFS/EE0Yp6TOmzd86xjPHMOMuW/ppV9exFT5pjJJdYIqO4qLSw8GMo2
	DvDwt0seLyXJI4tanlqHmr4hHX7evYWhHedBvVcGS0rSre1E/0/QfLTQ8uKD9Z/9LCL22XrRwmU
	LjAMasLA+F0JZWaxoR3tk5LEofXiGBHtTA7MnRimDmV9sJ1LfAlMwTzI2owPUcseXuPgO1aVRHQ
	I+kzXz5Ld3DsndTPP4Sbl+Hm3NhNTxBUyjEEmBJi70FegUfsGw91vsPkJWEJ/PCJy1iGUMw5Bt7
	fEG53gmv8V9Ol7vcxq65S+P5muY4L8YJo0pbERLID6qzgBN74NWNsIXYAQBRJR6BBnlkxYCQPQk
	nIQ8wm27v0A61INqArjbCbfaC0XPcnN06kpTGu/lEv2FiVBPdJVz7ldJYuI1
X-Received: by 2002:a17:90b:224d:b0:3ac:a1c7:20fd with SMTP id 98e67ed59e1d1-3ade9b30a3emr6861209a91.4.1793059981095;
        Mon, 26 Oct 2026 17:13:01 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066d631sm1184644a91.17.2026.10.26.17.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 17:13:00 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 00:13:00 +0000
Message-Id: <DMF6PRBIH8GS.3LZZSW3LDCMWQ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf 16/81] libbpf: Make arena 1 Gbyte when max_entries
 is not set
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-17-alexei.starovoitov@gmail.com>
 <CAEf4BzYrpYHS1V=VXF0PTRXkXQo6FnseWirR-ka-O9wKTv_GcQ@mail.gmail.com>
 <CAP01T775XCUmtK97tBcWsvOvUsGxR7AKCGqfOCgebf+-_WfhkQ@mail.gmail.com>
In-Reply-To: <CAP01T775XCUmtK97tBcWsvOvUsGxR7AKCGqfOCgebf+-_WfhkQ@mail.gmail.com>

On Mon Oct 26, 2026 at 4:59 PM UTC, Kumar Kartikeya Dwivedi wrote:
> On Mon, 26 Oct 2026 at 17:54, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
>>
>> On Sun, Oct 25, 2026 at 8:01=E2=80=AFPM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> >
>> > From: Alexei Starovoitov <ast@kernel.org>
>> >
>> > max_entries of an arena is its size in pages. The kernel rejects 0. Th=
us
>> > each prog must select a number, and the same number is a different siz=
e on
>> > a kernel with a different page size.
>> >
>> > A large arena has almost no cost. The kernel reserves 4 Gbyte of kerne=
l
>> > addresses for each arena, small or large. Only allocated pages use mem=
ory.
>> >
>> > When max_entries is not set, make the arena 1 Gbyte. libbpf calculates
>> > max_entries from the page size.
>>
>> Why 1GB then, why not default to full 4GB size? And also why not teach
>> kernel to accept max_entries =3D=3D 0 and treat it as "max allowed size"
>> and set it to 4GB (as of today)?
>>
>
> I would prefer this too. Also, commit log is confusing, it's arguing
> that there is not much additional cost for 4GB region, but then talks
> about the 1GB limit instead...

Yeah. commit log could have been more clear.

The reason I didn't go with 4G since 4k pages on x86 need 8Mbyte
of kernel memory for empty arena while 1G needs 2Mbyte, which felt ok-ish.
I didn't go lower than 1G, because poor man per-cpu in arena
implementation might use default 4K cpus, so just 256k bytes of
per-cpu space would need 1G of arena.
4k is a dumb approach, of course, bur CONFIG_NR_CPUS is what we have.
btw we also have:
static __always_inline int arena_spin_lock(arena_spinlock_t __arena *lock)
{
        int val =3D 0;

        if (CONFIG_NR_CPUS > 1024)
                return -EOPNOTSUPP;

For slightlt different reasons.

I'm fine going with 4G if folks feel that 8Mbyte per arena (that could be m=
any)
is an ok default.

