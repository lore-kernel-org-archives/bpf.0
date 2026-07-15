Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC721E097
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075339; cv=none; b=A5R/JiJYI0WWgkcuLwmXfVYEE/MOcj/BatpRqNzC3TYCNZvb4YI24BztAirXvNxIaEkB8OrttQlJROjtamMQ+6/nTwO6cA8lIvmpCeIh91+K5ArtQnDNYinjUG4mQIDd6f0MEqhnJGpARL650ZfBEE7nq+UnTOxOFGuAimuzue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075339; c=relaxed/simple;
	bh=mVH8XalEpQVWKwQH4hmeD5ib7D15mlvmrADRlbtsvJs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DURKyMn13O+zaawDcSp0zFzR74tn8jLDmWEmKCaJaNsNi7iX6xYVzBoTzUGz1+z1SQaZoRguNY2Fat4r2k4kPjYSOgyrsaQDd3RfTP031gVBM3KlEY0bgQqHHBilP3mCyE0KwrknV9Wvgs94e8kALYYSqrWCVgYQyf65jbqeXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V10ZRJ5U; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V10ZRJ5U"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so4882267a91.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 17:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784075334; x=1784680134; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0OXWiiZduWaFVZYnMUD3uONDkiNnSk/wggZx+AlWUVw=;
        b=V10ZRJ5UVM2IOH8M0lO7HRVmzsCvDT8aU8tEAiJoHDLdBkb5LiWog1FbklrgMC73E6
         FXUkEPnJim5sCOaBgKAy7KqDbNainClj4Dqrp1fNbA6cznvmSarHwyPqvMDEDgcWka3Y
         Pwkg9m6upbO1FXH9oCU8aFdfEwt8P5JMOakxtgj9n7JCe0nsqp5x7fzzXnBR2BrqhCvo
         tcj/y1fpHM1m/Q32fAuj0S+iTmU6q+ZEHVRanj347h3uoAJcvU2m+MzFSbsUu6MXnd2C
         s/lYuzqNBrm5IQ/ckag481Tq2T4ElCq+1s0KHeR62/+1y77xEruOVfJTp6gV8jQg/Xs0
         zvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784075334; x=1784680134;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0OXWiiZduWaFVZYnMUD3uONDkiNnSk/wggZx+AlWUVw=;
        b=btByyzxpKuWOA8uHdDuq862M77ozc9btDtRXx2t6K4BuT04IvUl09Llp4dgHQPElo1
         ERD0wmcxw05u/4AHNTsco1x8gN//YEb5HmI7Rkc+FppZYQg9H/qDK07LQ19k1yV+e4Q0
         fEEs2noLbgh9T2Q6a1Mkaq7QG+b7YnNIQLiGPEwF3AKDSqwgOSJ/gHz43lrd2BTHFUx1
         dVI3/g75gHl6czUblBLP8oCF7+ngbhLh+9rcuvMZ4SnM1WMysBRBW7/2coTYTAFL9Dh0
         lluBKcfg/uIfe43oZjIknZLWmgg9UHKvmEZqcQOwpG05ktrOiVaAKXHzjLnX/HI686YZ
         t38Q==
X-Forwarded-Encrypted: i=1; AHgh+RpXMfY7lA/7OIpSIkbV6MlIK5DQW7phUO0pIWxNgRRQAIQznagymu65J9YCC5yUZupaY18=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjh8BVU7n8HY4vNzlpZoBVmV6XJkqEziBwNgv8QuKhUewFbYkZ
	F4xD13x+mC21vGfG1gOD11Fh8ZnA6jdLCWEsmnc+Ot3Dx8XgS8bf3x0g
X-Gm-Gg: AfdE7cn8F4LDwM6M1G8h8d5zCi37CdwbOzxHw6juicWR+35ZxvV0RTweBobkAtXBkE1
	GZ19CWecSpmPV3mA2UHiLCcocdb4tHFbH5i+2ZurxLwgjzk17tp2pFHdup0p+TF0pw6FHHQ5bDB
	esuLZ/INxXg4dwXO2Evjig0Csn1cIt8i3TtvTWeYq1Zl6SpQHQ7zV8y3Lj8XEjtwxwMbUt2DGXx
	IuVYCpdeGrjclrFFFeYNEMflHjFr6WGBCFmQv2+vDIDcFQi6JTUVW5NldjiFb+LrwxrjdWJpfaR
	y0ydfRyS7LMn0tYKpXxeIZ8ACQSytIC3iSpnA1SekIpUQAuDxBmuDGzgJxYHYPhYr5WZxCK9lei
	2rtSuA1mT3Hkljbtc+/DOAR/CispVnwCvofpRsSeIXN5ywZMwuAiv/QCBntOyTtJwMW/Om5Jsek
	3UcYU/SwkGfNml1hWA
X-Received: by 2002:a17:90b:2e43:b0:36a:fcf5:64d2 with SMTP id 98e67ed59e1d1-38e17dc6ceemr4827003a91.16.1784075334195;
        Tue, 14 Jul 2026 17:28:54 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm86075098eec.18.2026.07.14.17.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/9] binfmt_misc: bpf-backed binary type handlers
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
Date: Tue, 14 Jul 2026 17:28:38 -0700
Message-Id: <178407531866.2243172.12944140194021045628.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 14 Jul 2026 21:58:05 +0200, Christian Brauner <brauner@kernel.org> wrote:
> [...]
> 		.load = (void *)nix_load,
> 		.name = "nix",
> 	};
> 
> Farid, this should slot underneath your qemu demo from [4] with the
> program ported to struct_ops. Feel free to take it from here.

Thanks for the recent update.
Is it still "take it from here" or was this left-over from the previous
series.

I think you've done the majority of the work here with the validation of
the few selftests and mentioning the gap for shebangs.

Please let me know what you would like me to do next. I just tested
reviewing the series with b4 + AI -- pretty cool. Was a little clunky to
get it to work but overall a good experience. (I need to tinker with it
a little for NixOS vim setup etc..)

I shared this patch series at my workplace as well. 
I think there is some interest in the work.
(If you are curious as to why, I can elaborate on that as well).

I hope you are enjoying your vacation.

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
