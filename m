Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843553B14DE
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026980; cv=none; b=C4kpwDeZhchMHz+lHmKx2mSclpl9YpdqCV6tv2cHLBm0LuCr5Mg/VUXWdg4pW4ueWVjaqPlZBmLNNafo/o1aSLpVnoANUwvbE/BOaKuZw6CfQZc5aTTo3Sjis4HH2rS+PftoeJexRRi2sOgN0SsM1uKpzF5Y/rjCjMoetOddQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026980; c=relaxed/simple;
	bh=a13AyurKY1c5+qqcymP6nHwCYS5mFQ93kWPFnMhP4Dc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJk2r4iQooPsBnTTLw2HxdkfhZeTByAd4u4F4lMwTSMuuZGAALsWZQ3h4+nA7JS8Os6YXdA++DxFjPsC4YG8MTr3iNQPUIPj5rPKJs45Hfep8fj5t1UwdaGwMoNYU8G4iPjpm6GTTTqZixTgLm7bFFpM47cYZPF79lMHjUpAdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4Vjw832; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4Vjw832"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc745abb731so888628a12.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790026979; x=1790631779; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a13AyurKY1c5+qqcymP6nHwCYS5mFQ93kWPFnMhP4Dc=;
        b=O4Vjw832ZQAq+hb1wDsEfYSh8Yz2MCGM5G3wY8dUQzw+q5Fd7tLHW2VfKn9Pfp9xwo
         lSDQk6MpoBAbFMKkNpeLuKiJ9b3qG4eZ2VVIFWDt6RhsaUHHr0bMYWiu2Lwx8jdL3jKP
         C1zgg8Ki3k+3M9fTg4VunPyozoACOrvTkduoMop/0ZAqCMAhsp3l3doJ05oecnM3yT/P
         xvZVCcsfFP8o0V6f00Kb44PcBcYMkqtH0kI3RXRtqNNJJxjeinOBnoB4nH6B4k2Rv771
         kyW8d7yY4WDBf366wPPaPUFBqyoNyUYdzGR0PibcdK9eTRNQ2Uuhk+YxcHSsCN/f7xt8
         FtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026979; x=1790631779;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a13AyurKY1c5+qqcymP6nHwCYS5mFQ93kWPFnMhP4Dc=;
        b=lnhOeQW1z4u8Hur+7Gk0eNSprywfloFkGv2QjDx4n6HIBwxwDbaA4Y++mlC0ubllb7
         /wUxMriLEQ1apFeNGchW/5amX7fRk+XoCf+Gy6f1vUfFR5iuvGBnf/yFOdYb0eYv6wat
         WG0PfG1s2PVWbRH5GF7GqKXHlVxGjH9rxAvPhpHZr8nZ1snGVDw9h+FG7+UEhJgbGdVs
         kHtTBtpVOHWdg6xClqlC3EVtomhE4MX8t7d+Euz7iq6g1NFSsEUCa0a3P8+fjcHz6ejo
         N1rgkNDH7+daf17I7zBolxr5RLuaRwfEPbtOhp4zLi0R6zczUAJ4/OHlkbnNHCxq4yed
         er/g==
X-Gm-Message-State: AFuF++nyGBZBvN6/fyYEMypUqJ2I6702+plLycMKxOM97rtyxQP/oIZ9
	3+awipjcLv/deF3umyGVfzzlrbMNHRUiF0wkCkjLE0Zz/H88gtN5Gv2c
X-Gm-Gg: AYBFou3iU2Du/CGfzcWtJ3kMuUfx81y78XBJsa7Jx8AmvnFGPIO77Lv2Iuw4RheOqLQ
	LIOqDyGGyThydzru3Dg1jj7fy77/GfgjPlx5d7NEx0iB4VQZyETIzT/zKZNaFClX7hfBiXSBwOX
	MpCwJNcUI66Q2nKgFgR5sbkBdb4/aIdVaKYpQMlolMqgHAxpGdPDqEY5/A3/C4Y+Tx3RdZ2N39R
	e6U2k86Ceb5dkYbnnCAREqneuZXYtU4xNYR8VyRZYvtjz7WwTRPWcdQQ6FZrYvJtzqP/rLU6ZIy
	2bMaG6eO2etM6Ol00BoY2DCaJEu75yFCFB9qjZAW1btNA3ZtWix5Uj4wa0cStQhK0aD6p/3iDST
	7dGTAEZO8SNd+J4JN5SVuUUeXECS02+BOO9JqSaO9fwerXDF6xHqJ2wxH9AmU/ATWvztlL/YcxM
	xp1GJ0h5FwY1Hi5FgWaGRaFYSuEijMsSdovghhZfRDIAME7hzhLg1qPp1df2ntKVXTUuPdAbPF1
	fIkD+f6K1v0lJYdaBspccMaRgJxo8WDdNz3YKhFNqLAj1CxIlEcatq2mQ==
X-Received: by 2002:a05:6a20:439f:b0:3d2:df:1854 with SMTP id adf61e73a8af0-3dd8c2aaa7emr18757138637.6.1790026978803;
        Mon, 21 Sep 2026 14:42:58 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9de9:26b9:a969:69d7? ([2620:10d:c090:500::5:f95e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f0c456c4sm454233c88.6.2026.09.21.14.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:42:58 -0700 (PDT)
Message-ID: <2a1875a99b173fec18d214419efbe876dcd95ad1.camel@gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: Fixes for out-of-tree builds
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Nico Pache (Red Hat)" <nico.pache@linux.dev>, "Ricardo B."
 =?ISO-8859-1?Q?Marli=E8re?= "(SUSE)"	 <ricardo@marliere.net>,
 ihor.solodrai@linux.dev, nickolay.lysenko@gmail.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, Emil Tsalapatis
	 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Yonghong Song
	 <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Andrii Nakryiko
	 <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
	 <martin.lau@linux.dev>
Date: Mon, 21 Sep 2026 14:42:56 -0700
In-Reply-To: <9e055710-d607-4a4c-95c8-eb3a0b4aa1a1@linux.dev>
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
	 <6f95ec90-194a-4304-9673-c7bb50065223@linux.dev>
	 <d3a251acf5131bea732e23bbd135a5fdebec9ad6.camel@gmail.com>
	 <9e055710-d607-4a4c-95c8-eb3a0b4aa1a1@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 15:15 -0600, Nico Pache (Red Hat) wrote:
>=20
> On 9/21/26 3:04 PM, Eduard Zingerman wrote:
> > On Mon, 2026-09-21 at 14:40 -0600, Nico Pache (Red Hat) wrote:
> >=20
> > ...
> >=20
> > > Given your series was defferred, and there is a "rewrite" coming, wha=
t would
> > > be the best approach to working together (between us three) to get th=
ese
> > > fixes in that series too.=20
> >=20
> > The, "rewrite", as you call it, had landed today.
>=20
> oh thats great news. I checked on Friday and didnt see it. Thanks for the=
 update :)
>=20
> > So the series in question can be re-spun.
> > Regarding your patch on top of it, it appears you can just post is sepa=
rately.
> > However, I am inclined to be confrontational towards changes like this =
one.
> > The purpose of the selftests makefile is to run selftests as appropriat=
e
> > for current tip of the kernel tree using a very specific kernel configu=
ration.
> > Main users of this makefile are BPF developers and BPF CI.
>=20
> Yeah we are trying to reincorporate BPF as part of our CI. It has bit rot=
ted in
> the Fedora env, and our large amount of build variant is where things are
> starting to go wrong. We need to build selftests for multiple variants, a=
nd be
> able to specify which variant we are building for. Hence the out-of-tree =
build
> with specific vmlinux.

Why can't you build the kernel and the selftests in the same out of tree lo=
cation?
The change you are proposing is contained, but it's a death by thousand cut=
s,
the selftests makefile is quite a Frankenstein's monster already.

> Is there any other approach you'd suggest? I personally dont work on BPF,=
 but am
> trying to cleanup/fix our selftests builds for Upstream/Fedora CI.

How many Fedora-specific kernel patches do you carry already?

> Thanks,
> -- Nico
>=20
> > Support for distros customizing the makefile is a non-goal.
> > The "PERMISSIVE" change done enough damage already.
> >=20
> > ...
