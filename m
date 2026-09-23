Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E23AA1BC
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136146; cv=none; b=rDll5/QJj5X+N0ZOKiToIzO7JKRMgfcc5dsm9k70h6/V8u9H1ZBUEH3m+ge71NXZ2dFaSW51oajk/F7MgarFJrOsra3A9cYKFyDG7XbDVL/3VMR/NpQzElqjEga/LCzT6Zu3NgsYotgOz2Edp57GKJSFL1iBUriG2cbmobnaK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136146; c=relaxed/simple;
	bh=+2gcuAyVI0aB8Lvcu8fN4nAMd9TizkviE8wvySatV6Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dVs8cYPHyFCqRnS7Hs9u+Q6gDNwOdP4QB5vnJkbpW8oEkVtflJ1ShYPLewN7nXU15w2cU1Sd5tPilmynpOmQzImivwEvRYlTCMoA+sh88kboxChASDAQklHa4Vfgc3bYqelF+4jQf8EauZksEUB/Y+AT5P3PeSeYPUY7dtj3sd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQEhsmKD; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQEhsmKD"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so288834a91.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790136144; x=1790740944; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=smyTmmEYYTZ4g1y6GKgMxOvAyTt9OblIyZ0tACnM2DA=;
        b=bQEhsmKDs7RdqZZR4u7bpu4y0K9q2E/mDDMmIxKIWNapSCYPoR6+vPcNY/NhI4vK9G
         smHA2fMPIgSSr/q7XqNz2lh9tD0sNLg/+LO+GzIRy7XgW9Jww3/q6OM4kxeqFuJeL4Uo
         beN45H2XTp+B0Myiytdm4bBrNSRW6qfmRA7AduMLNtQyXww1yyxnfJG10GQ5+luaHnZE
         /Iz4MWasus3n6qsPyQV4Bf1bkLdFy2UKY9Pr08wl6en7FXVL01KFYOuqFQhg+z+kecc/
         X1CAVn7T4tiZ/rc4U8fdCFwBy13yPUn9gVJukDvKDEwr4z4DHmBaZ8ibaPgkiro/a4xz
         tz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790136144; x=1790740944;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=smyTmmEYYTZ4g1y6GKgMxOvAyTt9OblIyZ0tACnM2DA=;
        b=m+ssZx9poM99g2txD9BOU1g0SjTk4E4H5YWDOCBu2FhIPqDWjOSSDa7Bl9qeIaaeMW
         ifQyCTNJn4MLriDPXIUNjHlbvx4g7vNaCUDL7X9dy4wEBtSfRzUS+Ha4NyHk7bW2D3y4
         kmyerBf+bqpI+qruuhSSHpB5P5gwInP4FrzWPYaNG52j6DfJK/m9daNwI+8RsFOEI2/9
         KLp0l6f2ovLrdulZOesj/GEe3ALL8yi+8v79w+3YcrItvm54PjO9HHeTvIKFcVxk/PBI
         eV5uA/agtBLd5u3dmOAtoViRKFLui7+mbrOEhWteZXNBxN3q8FeWJD4IQXp+Dy+bdspP
         7O0g==
X-Gm-Message-State: AFuF++nXXh7hsQXMvAOb6eDm1g9GCzYgMnzIn9yj/Abf1Yq85wjonVjC
	39BMoSF5508PXH4t2vTkuGCi1PKkip3KR4AP7LI7Z/p9NjWH25je+Ihp
X-Gm-Gg: AYBFou3DGkTLjpV7jqabvCFAgMGxjuQoBW0YF5sum/sXZqHiLIaI1KpREfHfcdebHNz
	uIgjXN9Verezq7/8uoKloWdIejf4QDTHGy8eYNoZwn3zvXTYcXctGiEzqiK/jan+MHV+oMDCclG
	MW+hc6bqz8bG6+rE/k0XFIWM1aXflRUsmiDAAOLVd8+j0kkj47VosXsEDQyAQvxytiwYS2fAki+
	I7z+6HCPehwAfMCA5B1wGFfy1ACisWswlDmNL0486biV/+cCFvDuPRvyBuBuOFcnhC+Juef/tWc
	vMX4N1u+t6lFLOMBmi6iOEGwypZLmDGLjks5WJGyDjiAkps4cwbrhVR1qvW+X8/L5+glYRVmLum
	7Fh4u10x67z+su+hQKB5gnWlWPDqMF2GSRI3p8V44PNMxTF5zCqpstY0y26VuVyl3kbxOobfkRH
	krOsLVHnT5l6r+JBVe9nYuXtCoFR4Mr1zSsN2GSX7SBlEA2APJZ/Tl1aeXvKkVJMapQ7bkVQ0C5
	V7A3f0JsocdQ/ky3nSnF4yRKyVpVtY8lb+D1YEvfG1RnONHhZl7WrSStT7V1Hm5Y35uew6lsjeD
	xgcwmRb/8czuqg==
X-Received: by 2002:a17:90b:3e82:b0:3a0:42a9:9c78 with SMTP id 98e67ed59e1d1-3a07e6144c4mr1293140a91.41.1790136143761;
        Tue, 22 Sep 2026 21:02:23 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07db882a5sm2431467a91.1.2026.09.22.21.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 21:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 04:02:22 +0000
Message-Id: <DLMEAUZ632XP.210Y7S9N70NHW@gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: crypto: Use AES-CBC and AES-ECB
 libraries
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Eric Biggers" <ebiggers@kernel.org>
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260923032703.59816-1-ebiggers@kernel.org>
 <20260923033742.D45A81F000FF@smtp.kernel.org>
In-Reply-To: <20260923033742.D45A81F000FF@smtp.kernel.org>

On Wed Sep 23, 2026 at 3:37 AM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: BPF_CRYPTO is silently disabled if AES libraries are module=
s
> --
>
> commit 1bcee0286f1c7c6c86befd107081ebb8a0fb0eed
> Author: Eric Biggers <ebiggers@kernel.org>
>
> bpf: crypto: Use AES-CBC and AES-ECB libraries
>
> This commit reimplements BPF crypto using the AES-CBC and AES-ECB library
> APIs instead of the lskcipher API. It adds a new BPF_CRYPTO Kconfig optio=
n
> to conditionally compile crypto.c based on the new AES library dependenci=
es.
>
>> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
>> index d7d25477ef481..a44ecfa3e9ef5 100644
>> --- a/kernel/bpf/Kconfig
>> +++ b/kernel/bpf/Kconfig
>> @@ -91,6 +91,15 @@ config BPF_UNPRIV_DEFAULT_OFF
>> =20
>>  	  If you are unsure how to answer this question, answer Y.
>> =20
>> +config BPF_CRYPTO
>> +	def_bool y
>> +	depends on BPF_SYSCALL
>> +	depends on CRYPTO_LIB_AES_CBC
>> +	depends on CRYPTO_LIB_AES_ECB
>
> [Severity: High]
> Does this dependency logic silently disable BPF_CRYPTO if the AES librari=
es
> are built as modules?
>
> BPF_CRYPTO is defined as a bool in Kconfig but depends on CRYPTO_LIB_AES_=
CBC
> and CRYPTO_LIB_AES_ECB, which are tristate symbols. Under Kconfig rules, =
when
> a bool depends on a tristate that evaluates to m, the dependency evaluate=
s
> to m, which downgrades the bool to n.
>
> Consequently, kernel/bpf/crypto.c might not be compiled, and the crypto
> kfuncs could be silently stripped from the kernel. Existing BPF programs
> using crypto kfuncs will fail to load with "unknown kfunc". Because the A=
ES
> library symbols lack user prompts, users cannot manually fix this by
> explicitly setting them to =3Dy in menuconfig.

The bot is correct. Looks like a regression.
