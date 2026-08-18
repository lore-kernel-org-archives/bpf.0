Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4C3A6F09
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041516; cv=none; b=eTmWJdlLO2kwtDlSg5NsYbJtTW8V+r4eIGzmSuYf/F7993QQFceJSE4fUZEqGYkOsttxydaaDfHAZdbu1tF//g8A57hQ6Y0nevezbYZdbozUfdbpdACgs/xfr4OL6JzqtVZMShZtoYEoGVZmbYDehwXe5+oeTEuz/3fkMxf1Q6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041516; c=relaxed/simple;
	bh=MoKxMu3trW179Mtx8T4bCvrDvhYRCia9C6wY8DzRR0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYvL2nSE3rtlKQeDfGgODBNbNR986X81tTitutfvhQxj3av4lGot5Zj561xU8xxMb5mmKGmHfaQY1lwjkDuzb3lgtmGK4BLPBi8rxUm/0Ht1hpYREfZ8RXLJRQ6Dfgm+RnGNDHOVz5jEEIub3zoSmrA88FtTpuyD1acgvLzwtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvKG9+94; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvKG9+94"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so2839716f8f.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 01:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787041512; x=1787646312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MoKxMu3trW179Mtx8T4bCvrDvhYRCia9C6wY8DzRR0g=;
        b=qvKG9+947OEymD95nqWCTSTa6+9aWjlcxfnGFM/3eCE5QYh4j41vIvS1Bao6h1ZPEq
         Z3zN8vuTaTq1BZAorKCnsj+LRSMd2KC4PafUtK9lQp3iaABI1Cp3Wu+Bh6ghK+Oge0uA
         SWjSQbez0MabHBqfoulRqacou8Wl/88+MBVaUVhKUVmEBdKikyv4L1pxzAJnPDLhHNuY
         E1msif29CTbVZd0xlh58vyhJcJRsbSyTAixDtUAV9RubUzBj/bRBX8Ytxi3PNhyFD+6o
         TfuJtPVCtwFebPklZOTtEg0YpALYowMc1tt058vn7Z4Wt4kgcTOL0p31XRzc6k3GrhTd
         VrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041512; x=1787646312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MoKxMu3trW179Mtx8T4bCvrDvhYRCia9C6wY8DzRR0g=;
        b=DOUi+X2/kPat0G2qQnv+0AtqAcZP7w4QPTZi7ZrZeU7CAHA68bmjm2xr+kMJNzokBq
         yiQW74/DZE0nWcfpylbz8EOKIrcVEHpzAtHMzMOYvXzArKBJkCW2BMn5O7ejcHMwNGYr
         5GlsiTqK9S0aLHjOoPaZH69woq7RS253m1ftX4euzNrPqhDqMswOEr8/rJEvkJpal1o1
         RN7DKRHJ/HaB+b0C61PBi8FLhOCPs/Rn+ssgYfrIGTzp1A2/0wHnaf/yOCjGqwQ9gvoB
         iLIFUsgXkjJcWPhDSD/dRNUDgGAXH+J0u+nQL2LBLD4wTggm653jxMc51P586Jx0zV4D
         UDzA==
X-Forwarded-Encrypted: i=1; AHgh+RrszDBhrUtv7WUW1WFXHy7gJE7X+PsOwc1zu12W+8QDIEcIlFpfKtJ0OO5NEPcR32CHQ+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQMu7qwKH2xZ7EhQnWUITlwPSqOWM8waYukHGUP4UHdGOfFaD
	DnLvSyBt02XXcDIVUtyN/cRXmHlKEvR3T46j3/gGPA0XftWWTvjH+dC9
X-Gm-Gg: AR+sD11LjojLvhPpQIaYDXd/bnq9DLRo3ezLwWgQqmwxNXKp7bGSKH/7T4m4CNn1MPC
	559YFHOHve6MNrJCddJELBVoo/iOOJtLjjlnFIr8sY1cswlrnMDraoxosD+2dg/W2W23z8/uoYn
	jUO64nbG4uHWxC7SRkf0ESyMbiz7XbP7LT7x2rbSqpkwY+MsqGwJ/qw4j6S5V+0UE71emaknqaK
	Pebr+Kg7NN6wHRwrA6ZOWRXpYfsZ/xxjqiWNqKFJoKXAH2eKgUi3vddUTS3qXNuWDDZIi3jfQ7Y
	hTiUI7ILzb55AGO/lV/eHlb4EBU52QWYv7SLEsgY4qGqPKZKc8pzcRpy3W0F9WtzwlHgu+HE9LN
	mrgE/AY6T9R0sy2w6yKg3ggCkYUmMuGMVZB29z+AQhePxsHH7K/qtAtTpDER9RRV2ZTjFk/pyyV
	fR6ZNnE33bXciTy6tzF1OEXukjM0v4fre9NTgQexVWHyvvOgwYE1I3f90W6rXKfsa7wpQf0tOdK
	M3+
X-Received: by 2002:a05:600c:3f06:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-49987961c32mr517262115e9.9.1787041511977;
        Tue, 18 Aug 2026 01:25:11 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482aa084a64sm4907363f8f.17.2026.08.18.01.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:25:10 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: utilityemal77@gmail.com
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	david@kernel.org,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	tasos.papagiannnis@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next 2/3] bpf: Add user memory access kfuncs for linux_binprm
Date: Tue, 18 Aug 2026 11:24:41 +0300
Message-ID: <20260818082441.4091-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <any3wCj66dWbwgwT@zenbox>
References: <any3wCj66dWbwgwT@zenbox>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review!

> Would it be better to handle that case transparently rather than
> requiring introducing a new kfunc / leaving that gap open for NOMMU?

> Either return an error or perform the copy from bprm->page[].

> Unless there's some reason I'm not seeing.

My understanding is that there is currently no way to use these kfuncs
on a NOMMU system. Although CONFIG_BPF_LSM does not directly depend on
CONFIG_MMU, as far as I can tell, no current NOMMU architecture provides
the required support to use them. For this reason even if I write that
code, this cannot be tested.

> It would also be better for portability across NOMMU / CONFIG_MMU
> systems (the exisiting kfunc is never registered, so a program using it
> would be rejected rather than able to handle the error).

As you suggested, I would propose to register those kfuncs
unconditionally, move the ifdefs inside those kfuncs, in the case
of NOMMU return an error (e.g. -EOPNOTSUPP) and allow the programs to
handle those.

Does this sound reasonable?

Thanks,
Anastasios
