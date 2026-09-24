Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263D8472
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215999; cv=none; b=ZQC05rHw7wrLfDXcwIzGoB21+/ghT54rwVKSr7ZxbHe2glNaoZA8p4GZsR3enCVWWstYoRoOV2SbuAHutPLiKGdMK38Fd1hJLhsEWdzmkoNIFwZnuQwPA5Y80z29zIQZkA0rQPJ3grHMe/UInF22ASs9kXdEyUsNN+v9hQleFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215999; c=relaxed/simple;
	bh=x35MklNMYq7hOmouEr5RA4c1GImCCXw+5K8vLGsSCgQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=FI6eTlaY5AYQXagHDA7HihoN86hMhL60v2Vwj/FBniUiZC/xArDQkQsPxV2Iu92wtLmhUf4kw9bhm/ZduTZa+t23aWi4/fBiMSb8OmMhCtWGqwkthlBB4zWSRhbI8UK1dPHKCI6w0SpLxUGf20LWaBMoIK0q/Og0NKqkEJv/d3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N22VV6V0; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N22VV6V0"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8692a8568e9so763864b3a.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790215997; x=1790820797; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x35MklNMYq7hOmouEr5RA4c1GImCCXw+5K8vLGsSCgQ=;
        b=N22VV6V0Wkm2km2YU4XTG0dG/LYd1PvMSCvMwHW+LCEEeAS685W5lT5ASqCFypPiUx
         y6V6HWWdPWQU1pXu22eyZSevRyonVgA1tKJCjeBX6GOt70KEaKgnxbpxZrDXFund6WMR
         df1IrRTtS52c8Ki+gplwIi9a/Rt4GR1ZRaxkDeGC+r87N9SNkftgqd16HL+8sgvD6sBd
         vC3juYL5l9uKm9fe5sArA9uadBkhKpRv19cGcMXgGHT893O0VEj8II3ZdB9LTmPAhJKH
         fumtk1dQ1hBs/SllvuaCtg2E2FeQdwO9/Il2smQ/lnHGq7fRlrBx7NrrBO4vLAFHsENz
         8jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790215997; x=1790820797;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x35MklNMYq7hOmouEr5RA4c1GImCCXw+5K8vLGsSCgQ=;
        b=OCzw8ClE1K4WY46xLPJ1BW4uATcr9iygmeuXRPhV2gkIhjajhSreFzZfdNL63pwi9U
         pdk2ev962uotn7WHVf67haL62RYYatsV+zeqYUY6wozfW47s7QJd1x5fkhQK1gY2aq+N
         g7Y7qfHtZj+ou42FQ0gGoK4xVf+HSV64dFd3pFVgzBbmJFi2k4JzILiuVFAewXKjidTy
         KPzEtW1HmgpgQdOWH4wVfogC6hq9ANMqOj9MD3J4HgXY9tQBEp5XpG0ykNtpnweHsi6p
         oNWv593PmNPQ9LccxCrR5ClbqifYnZB4Ov+ok/OBAIhv0uxY2kVaCDtWRnnAp/TLbu19
         27nw==
X-Forwarded-Encrypted: i=1; AKwUvBxWL2qAwEZ1UyZYDtayyz5sBqsMQsDlXLJnLvSraVP4sufgRpkjbeJp+Yk+kDuz35xrjRU=@vger.kernel.org
X-Gm-Message-State: AFuF++mkH1M0ysUphTm2SRwo7w+kdB30ohM5jFMncaqcv9Z9rCsv/1Le
	JXd9LOxkfVESiVITNZm5CezoHjBg4OcBR6e27212fPKovLe+72bJmORr
X-Gm-Gg: AYBFou0oDh0rN9FlOUn3iNE2spNPumxlARilVokKGHTDlDZp4f99ffa/eeDOSusoZNE
	zW+cMB5pwfd1rLA5aniaXg6sDakj4JahBqOyNCWEcHUNzLyzzxgyJJ8MduaIeWWPp2+R0YEMYF5
	/DwpVW35vsrs3ypQ+naS843yCCXKV6f5V0EPMmzUAqC+ywDKyxnN0ej6BPPcKKF5AlSzJl3sDco
	efpPbychbbZakkgA45OyVEIM+mXpG1bZ/hm/Rvxu31rNT1tOnoGRC1eK0Q3edK6TDnq4DQTNubh
	ah5BKD78BvWq2Zsmpk68IKVC7IKSNlwhkPGux9sEwoI+4nkr8KyXogw+wdgVb8Bhh6OF4f1Nkm8
	ppL/Jl2qkuLICw9Sq1E6zOmO3j0QoA6ac8wUnG20FCVuH4UNb3Py9m/nL/mba4PL7Ss80t9hs6m
	Y2hKt5+ozNDj5fTSofzpzOK/EcpWltk0tLzrRol5Wo/FMCh3TjGBMvu7AQEkm6Q/sjpFgZt74+p
	90xpZcuUAvoYyhZHD4ZtQthTAGn7Ll0ont++4jIB+usD9xcUnlkxh0SBrsj5HtX0KEZGlaPbztT
	ew1Y
X-Received: by 2002:a05:6a00:4c19:b0:848:34ad:3d6c with SMTP id d2e1a72fcca58-87e9d3e4a5emr866542b3a.15.1790215996849;
        Wed, 23 Sep 2026 19:13:16 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1afb8e37sm2068035b3a.5.2026.09.23.19.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 19:13:16 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 02:13:16 +0000
Message-Id: <DLN6LV13FS9D.9RNUGQBR7ZNS@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <a.s.protopopov@gmail.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 12/17] libbpf: Resolve pointers to functions in
 read-only data
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <c292100880a6fff41fde6ff71c9538f82d1c3af90f5c478989768a14074a32a7@mail.kernel.org>
References: <20260922011323.1298619-13-alexei.starovoitov@gmail.com> <c292100880a6fff41fde6ff71c9538f82d1c3af90f5c478989768a14074a32a7@mail.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 12:33 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> Should the functions be appended only when the program (or one of its
> subprogs) contains BPF_CALL|BPF_X, or should libbpf probe for kernel
> callx support before processing func_ptrs?

yeah. small annoying bug.
Will fix in v2: append the functions and create the copy of the map
only for progs that have callx. The rest keep using .rodata as-is.
