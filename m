Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6C02DF13E
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549176; cv=pass; b=J5sjMKJ1F/bb+46ClanETu8+YRRfH/ZmuD/j3odHKaVZLYLhg2WoUfSjrDV7DXzJBUp0PAng3Cq4OwUWQafUxVmif/lfrBOTcy7aJ6GbmU9Ev3hIBpeNczOeUTPRl/BQfaBXXRth5xWt0BQ3wCVTknMnqVrt2rKpJjvYqVsDuP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549176; c=relaxed/simple;
	bh=qXweQlSTY439N5FsVp9L79ILRWkzGCzUAOwk19AKHIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVOfnKL/M1m6kOYckFpe/pt2hS6jwiyFhXoImIQftlokDpPcLlhERqFOO3bYO6Qz7Fb0o+5msqPxDoREZGmtvz/ftyClsqMPKBWZFQq3iiX8qedmL/ZzViQpnLlNrWf02cVm8Cu7wQjzfGrMwI4f7mIgTUS1+pGg9JEEa/kXTws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTo0ODJh; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTo0ODJh"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bdf8add254dso20808466b.1
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779549174; cv=none;
        d=google.com; s=arc-20240605;
        b=T+F1hVhlUWR2MGDXslDQjIk2AgDklR1Dw/O/cn0xJ0wpZN3WRF17AkFONI7LReCdlu
         6JVj/AutwG4WMOg0GUz3tP8QYlpQ5pBNzREARJBcxGp645NwP0CVjWMXJ5CONi7/taru
         kNOxaoX5grhmZoi/k6OwiqLAMITEJkdJqaaLCAEysvfQi6TnXBLS3F4Sq2iuZsktyscf
         PvGCIGokrhUy+ertzYd0hrmEOyqoisMWfd/d0GNksoUV+oAbBPAyA8qyj1OoRsZqaPwl
         l/GqAARmj+gyadZSSPe/ZHRbeJEKa8CVb4+Jnpl/+Huf5Y+H3NfGAPrJIDIaZYj7VmAv
         PPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qXweQlSTY439N5FsVp9L79ILRWkzGCzUAOwk19AKHIs=;
        fh=0E4CcxvDf5L77C91PrwUQ2NlBOW+38e65IcY8z0j/uQ=;
        b=g4AFNHp7Vs4DIU6RRCv+d3fyYcTnvPm6TANGZcHguRS1IN7SGdJkw5W+lBcV8hbxti
         5CIRcikDmKOPY2tWMBzsZdAQ5jB9SRZPiI04xEmHNRyOlL4CL5v+hVJoioYTKspSIHRa
         3flpGafAdLlTWIn+tqYqNUYKObLMH5wL52oVkT0YFHvKoaqvCrIcdlA4WX7nM7l5S53o
         sh31h1wVq21lrDPVer3hNd9CS5Y4bOX34swotVcTjteXHPGAFtWP0H93VdEzgfQSUzN/
         8pbblIPIBjcHW3wU94tzSlYT5dbwWElj3w38VB56ZNA4T/cral6THPO8Y6btdQbi0uVd
         8oLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779549174; x=1780153974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXweQlSTY439N5FsVp9L79ILRWkzGCzUAOwk19AKHIs=;
        b=sTo0ODJhSGgTPaLOFXzFX4HdjIkATRqZW+6paWIZBh/tFbagXigSvErYZaxmiO2If+
         LIUlzW4fwspUx3XxDEDYtUW4pGMTKgLQk9VQjEOV3cIySfPEp1ej6fW5fv1auxASY+f7
         AvYQh5EI1UgGlmzZTBpoBjqNXJNFdJdUUxGEXTmDigpjLlJcO1xXsxknCx42bZnv9Ckz
         zX/oXNN0DF0yECo1W727AGpOyvL07CB2AvNJ8ipDHPxkOcgfjdstA/WpOHQOZxOWiPvc
         Nh/JrjB9kkmYw2XxDtqjc7JOJ7riD+li9CdtMJZZCgubRLGsHioimyEpGO3omLmA4BMY
         yiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779549174; x=1780153974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qXweQlSTY439N5FsVp9L79ILRWkzGCzUAOwk19AKHIs=;
        b=k0+ojeL+92JWo+x0EzqVJYT1sq7zfChauYx50c+Z7NhZ5bUALlEGqORnhVOln+tuzn
         5Zph3W68RRTMPdCbOVAW8SSKN+RCrRNIOvMR6S9TzGgj0yHPFlgKQA4/ME4+7pN/M29Q
         qyq+mwFRD5pFXytc4QOpnfx4gEN5jBVzUCmUPOhEiXnqIigw3x5/rLOtjsfuwMvGQUCL
         +pzbbj32ZqPduF2Tu8jRjVSV56OtmKj3ABsuSl9oAyKJiumfpEldpA2lKb5cCAwXpvR5
         919FysCOb7m4IvmFV7Q28cGOi7Gqt9cuS1zG24phfHwDqoHqTTUL4aE1Z7nD2wx9TSL/
         oiJQ==
X-Gm-Message-State: AOJu0YzzEUGxl4MGt8aR+J/zJk054oaELF5oBaPj4V6905Exuq7NPwhe
	GT8ExuHG+n+DLWr7S0zFWewbyWCNbop9ffBYSiaTyHzKU9/UJ+xnE9A/mXxoqwkR8PilkaY2quo
	iLsDWECLW34LAhSi79FLty6FLt7t7i+JB/Frh
X-Gm-Gg: Acq92OFMe5IC6PT/Ty0VzhX4URf7WT1LSWCDBbDFYHTL/TTqKEAyWRnluQqZmIl2O0p
	4c/sqlThD/+DHIB9W6/7kLEQ+ODXTd7wzaBgpZgHh3rMvmbLJB+scBZdry6jaA6w06ZlzDIbOfe
	Jh/sYqhoDsw6yq5/xX1xR1mA3ocm24aUvQmson/KSiNA4wPZRF2TrHaq8Lg/y6SxOXgdIkQOIe3
	27iwpjCAEr93siEgV5/dacYwfDgetSFizHwTlFro+lMukMCljNTYBRNvNKeyq33GUKWDRyVFWA1
	eKK/vhNCFezvVHvMGbLNiU1+QQb0+dHTm3siODmKZXPoJ1VJ1vsTwkbgv23yBk+k9rwIVomHrlH
	83c8=
X-Received: by 2002:a17:906:8f15:b0:bd2:fcd8:4cee with SMTP id
 a640c23a62f3a-bdd269cc4abmr545521566b.44.1779549173807; Sat, 23 May 2026
 08:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522215337.662271-1-kpsingh@kernel.org> <20260522215337.662271-3-kpsingh@kernel.org>
In-Reply-To: <20260522215337.662271-3-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 17:12:42 +0200
X-Gm-Features: AVHnY4JSIMlMLQk982pu9YISI9sy52gJIfolrDB7dAzvIyROzeyE2dWq6fSbhP0
Message-ID: <CAADnVQLJsvCfRxyLT-NJRubwSPTNd0k5bEp45Zyu9q1B_3oG+A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] bpf, libbpf: reject non-exclusive metadata
 maps in the signed loader
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 11:53=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> The loader verifies map->sha against the metadata hash in its
> instructions. map->sha is calculated when BPF_OBJ_GET_INFO_BY_FD is calle=
d
> on the frozen map.
>
> While the map is frozen, the loader must also ensure the map is
> exclusive, as, without exclusivity, another BPF program with map access
> can mutate the contents afterwards, so the check passes on stale data.

Hold on. How is this an issue? excl_prog_sha guarantees
that only loader prog can use this map.
Are you saying the same loader prog will use the same map
for the 2nd time. Ok. I still don't see a problem.

> Place excl_prog_sha right after sha[] in struct bpf_map and have
> gen_loader bail with -EINVAL when it is NULL, via BPF_PSEUDO_MAP_IDX at
> fixed offset 32. The 8-byte read of the pointer field limits this to
> 64-bit kernels; gen_loader needs target pointer size tracking to emit
> the right sized read on 32-bit (follow-up).

I don't think we can go from maybe-racy to certainly-broken-on-32-bit.
So only applied patch 1.
