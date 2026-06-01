Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CEA3672A1
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780343758; cv=none; b=SmxiN8eLuOpXXhoslfHRmCBamdDTlejqD/G4VlVlbqfXa09L8OLn7XN91KjCcmtKObRF5M35CzrU4ILW+3jyHdkQNHOniNTkMEv3roqV7KqJM1ORf7gyvVmFDsdQsNS3L9tfZUiGAEEob+okX4p1YC7jQsSfbjZYSkROx4TWbe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780343758; c=relaxed/simple;
	bh=sWnpioqUZSD8rEBStm4qsYUNnb4SKEqYdypZggBKrto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IvBGuhEEwGpvZq//exJANFdtBKEJd3zCoaMKXTHPktFFhy2Ju1R89AuKcUcyYmZfMd/NuBm8ZXAm6Fakgv7pc+1kjdSB/cfNLWx0Xdqad29DZu9Q6dxQyR52D5s9Rz65vuYB9bU/JwSi4ptyNhh9uoM8kkxmQNAqsQ2rAFXyu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZqgwsAD; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZqgwsAD"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1363fe80fe8so12590297c88.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780343756; x=1780948556; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NKnmHsCAeTMcu6W5Om8ov3/DdLkCeKtJ/90Z7D27psg=;
        b=ZZqgwsADSSmTokY6PsbsbyDPybKC7naUQo+1unCFUH6ZdL1eTzeftbD4MhULNdPYK4
         8MVZeWJJDCPY3A6+7azQki1yWw+bAuSc6e1ZGcTayMBQL2cyMPlAKxfzCLLmkVqxlC1u
         1T7boW2r4DmlpdmLbUKCwCu79ysdv5lQFsL9hZv33SdpVMytOPlyogfXzlX4l9NxTlCa
         n8TQT6jEZO1suP1irnOkJ7jvjtaoeiD4tbNM8FOEdOjZcuulToG0LP7F2kwfpWUvufkC
         5SYW3itKy5YC026w8kC903WKm/rBhVagiX3+OevD8Q7gDI0cSdQ2dtL33bjSKI/84j0U
         dzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780343756; x=1780948556;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKnmHsCAeTMcu6W5Om8ov3/DdLkCeKtJ/90Z7D27psg=;
        b=p/7g1QHe2yxwzktO7IJRpWv3CJpufxnzDnpuCUm5JUmB4YyVV4qjcZXiPTSems5NpD
         oyfrt/RQnpfrfVQfM3rWeXxEQ2uESNJ3Kc5QhYWJfr7MEKYKpMHAE/23UktQ5GetrT5G
         H7wzop1m2b5O1vVurc7IiElVXt6HTK+WXZ1K5rrEBk/cg3GDfYEXTlMnSDuy9j32OvdY
         W5qJf5RzX4LGgjXg6SYY4GH8YrnQVFXItTRwx0PwgyTUWHyvDuSWO9meWs1+GBSU516q
         tzHDEEaEz+qNMEXN4JjlN1VhkGgoM1u5+/+OqEHggpJuPlU+LtnSakkF2FhrblQZeDAl
         gB6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+xNRgRlmvThRlsTaR69gVdwwgnF3rw3jzc8qbnvfrKZcaiUOV3h6JS985a+rQoX88tVKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtIaNXalsP2fQj5T4SnKlKgRAg7RyHYBscE1s01m8o4hxC+v9
	QWwPI3lnaNSiY+HmDmkYcHsMrnqnrBdBfKbYMRUV1hWXigf5d+PmgFvQ7H5XHor6
X-Gm-Gg: Acq92OHvFPG+EYFna9MpxdLQrF8OodCg+O4FqJp3uJ66uy9LpWpMtF8fu8NV5fGx9J4
	qe8+vbmwcrw18SysPvRagzFYOBWA2SH2Afk9NYInt9QFq3zAZbOFDw2yRQucGP8mm9lg0UttZaF
	zH25m+Ly5A08zDYP8xqwsXU5gB/ifPjjlQHyzf3kkG12nQgy4uuK1uOpCX96CFW0ufvQ4SXXdSx
	nwxjb8e5p58w6Ut8+zZ1SszONqfMHyGSOuh5Nrq/h+JB+874pDwGdqucxS6QwB4DJNUFYUXw6Py
	yaNG3OzTQmpjI1esRwCOrVi0D5LUEe51/qKrFNVhsqHI2dGEB23wNK9WWrYE7LWe0cmjS6aIvaG
	0EA0XT2YpRKfYkOuwz2wiAjOzCwRAkh00aHV9C3poC9tR6EuLvaGNktmIWfzHCRi0LBqhmYP0pl
	0Ia5yuYgXuYcquEDMJJX9EeZR8z+7oyHwzOGMBTJkRi55d+cHonK0e9QbyoIFvsJlnP+chcuxhc
	3579n5h7wXZudk=
X-Received: by 2002:a05:7022:ef18:b0:134:a710:d908 with SMTP id a92af1059eb24-137d3e03856mr5447896c88.13.1780343756323;
        Mon, 01 Jun 2026 12:55:56 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:75c0:5e8:2488:8b9e? ([2620:10d:c090:500::c14c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c7fd47sm8097435c88.14.2026.06.01.12.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:55:56 -0700 (PDT)
Message-ID: <2a37e025ecbd74d308898891298b7c3417a912aa.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 4/6] bpf: report hot simulated
 callchains when 1M instructions limit is met
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Mon, 01 Jun 2026 12:55:54 -0700
In-Reply-To: <DIXZ2VPVZP94.ACM1OJMPGF4V@etsalapatis.com>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
	 <20260527-better-1m-reporting-v3-4-b3ede0588a75@gmail.com>
	 <DIXZ2VPVZP94.ACM1OJMPGF4V@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-01 at 15:50 -0400, Emil Tsalapatis wrote:
> On Wed May 27, 2026 at 3:29 AM EDT, Eduard Zingerman wrote:
> > When the verifier exceeds the 1M instruction budget, the current error
> > output shows a random execution trace that happens to be active when
> > the limit is hit, which is not very helpful for debugging.
> >=20
> > To rectify this, employ a profiler-inspired technique:
> > collect and count "callchain" stack traces that the verifier visits
> > during program validation and report the top 3 hot traces. Sample
> > callchains at instructions marked as force checkpoints and loop header
> > entries.
> >=20
> > When 1M instructions is met, print a report containing:
> > - callchains verifier visited most often;
> > - disassembly of the subprograms referenced from the printed
> >   callchains.
> >=20
> > Here is an example of the report:
> >=20
> >   budget_nested_call_loop():
> >     ; asm volatile ("                                     \ @ verifier_=
budget_report.c:44
> >     0: (b7) r0 =3D 0
> >     1: (85) call pc+1
> >     2: (95) exit
> >=20
> >   budget_nested_call_loop__inner():
> >     ; asm volatile ("                                     \ @ verifier_=
budget_report.c:54
> >     3: (b7) r0 =3D 0
> >     4: (07) r0 +=3D 1
> >     5: (05) goto pc-2
> >=20
> >   #1 most visited simulated stacktrace (visited 499999 times):
> >     budget_nested_call_loop/1 (.../verifier_budget_report.c:44)
> >     budget_nested_call_loop__inner/4 (.../verifier_budget_report.c:54)
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>=20
> Minor suggestion: Can we make the N of top-N a #define for clarity and=
=20
> to make it easy to change during hacking?

Yes, makes sense.

[...]
