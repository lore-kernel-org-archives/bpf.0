Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABCD34D910
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780023825; cv=none; b=ckG7M9j17nWHlgsW4XTkOrLCooJu10C0tVbhw89SkSyjlO29LM58wtWcDMbuzHlFQjQ04/RHyiyQWH0ZRbZPXgPdx03ZnUtZpb9AdfgUlVsyzTlnCAJ70AB+Eygzywh3z2Qk5HweTx25Fe8bgKjUsHdtrtBRwLJGWW/uVc75Adg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780023825; c=relaxed/simple;
	bh=z72FZk3KboM5L2QhGMV/3pBoPr5ggILxlVNu2Kq6OVE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LE450F3nc4QKdKQx7WP0UwdDWpaUV/FSSSCyYfk7nETZSg74puqYgJZu6Kxncu/axUiaHbKD4x8x4Wlv7+lPuyc2KKEBzbo6c+Emm9kboL6/tyFDaan5EwXgY59j9AnKyDP65p0q+KRIxxji69/0P69AJG/iZPzuc9SFKeDM60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHM4A3pF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHM4A3pF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bd2c147abaso82284215ad.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 20:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780023823; x=1780628623; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nlntuG2EFVeWGzrVr8XIJV7GDY44HYI/mrkXLhNBYxs=;
        b=OHM4A3pFOgYY+lm3nrN22PT4ue8hZyzg1SJ1YSbt1sFlt/cmN7h/AiAGQ+MwiW4C54
         zKiTHo7jZf1txvm9Hw5sGy7S0t+lFBH3XV9UvjzowyZwcRH0k99JT0L7/r/3BZndXnHc
         56ZcRkFZ+0f3yUdshQ5KyMuoyxvniP3j0CyCLXRGmuTiR/UJcfEvYiQ/kReLHb9TNcHY
         peCDWsKHjt+rDOeLV1zgbl5OwprPhTwGRg99UGMyBb3Xc9fEnyQhJ7BnVDRJQIc3bvK5
         k3nqCAUiFbYxkIsa46cpIT+YUMfV0oTvh69O3oYIVTvH/y4SJkNoxEIBcwDxuri2NtBe
         ARaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780023823; x=1780628623;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlntuG2EFVeWGzrVr8XIJV7GDY44HYI/mrkXLhNBYxs=;
        b=EI9K8AKKwu7NI4nh0GzVtMLuq/nMV0Vq6Lj8is36Oikn2DSrJj4GVpt+kvW3bVeHHo
         OSg4DnaSPfGudofOy5lU3wL1x6CARFIlDZwHJ+JOcCmO7alSWRmm+xXUzVYlTIrK+03I
         f49IxGhjnWkF9wqyy0sJYHjsJjko9zIDfwr9L6TsRhojvfmjix5cm3764FS/YYHUB9Ye
         A83FG2OaOsot2wIJpGOCYQCXCQJ929OYyH2jfvbn+oOCDSCCjok8IREh4kPEPOyPW5Mk
         4wPQWFZu70atKhnweJjE+ud2zTjEZXtZ6bhLuIviKIvJ5NY53JMozzaBHzBMGUs1zZam
         tILw==
X-Forwarded-Encrypted: i=1; AFNElJ/OuGgZvqFhbfweO6r3XcIA2N1pjnzMzqC6dmS115Y0MGqoceTPV2sQOVNpORCdL5eDklY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5YJat/WqJVA4PPcKvSn++N2QtAv+1iJff5B9CnlrLmaaitzg
	PjWp+3cwXZcgcDbYiC5wFSljp72bVlLGwGPKVw1Tc3rvmg8rDf3/GsdG
X-Gm-Gg: Acq92OEyIaXp+drxLbRwOlrr9PUFp2UhnxpmOIZDVxmwKB0E8+3ePT/ssRepobyu7rr
	iXDVaNEA9ueqDR/8AL8OvzNQXqe3Vr4UraMjIVIwxx0zbGH9jKHvIVvemtEnlHJqa9W9O/JSj3Q
	ownMPm81YviphGKIeI/bgWr0zyp9RbMZauHxnw5PFaZ0K5PQBtvtP0jLIpAg6s93nv2udYZYDrx
	h9wTGtVxABLN67dMPkowdua5QdKhiPzRpFVROeUstpgwlu/fUuGgL2z2+uzAhfjr6C7JSPBNZu3
	ANnGd64iwhf24uAIfhX+m79NObMvChhpi716C2LrJ7I9oAm4DJroXmq5KdrR+3PpIrclUWrQBug
	s7nU2da+WeWC5oeIabXdKJFrFlUnwGNLsnkJ1BZUONo7+8NbKnID63bl4q/7DZ2MG4P7jyQUoSU
	TWX1pJ38gLgPWAwpIKTL6UX6vAgNeLCuK+LvkveoKlGPb6LjpigEN9VW9vFXZFxt8=
X-Received: by 2002:a17:903:9ce:b0:2bd:a5e:4c66 with SMTP id d9443c01a7336-2bf2064efb1mr14331975ad.14.1780023822969;
        Thu, 28 May 2026 20:03:42 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b018b6sm1963565ad.43.2026.05.28.20.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:03:42 -0700 (PDT)
Message-ID: <43d76deec1c5aa8a2029f907ad9c119d83b9966e.camel@gmail.com>
Subject: Re: bpf-next verifier regression on unsigned bound checking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: YiFei Zhu <zhuyifei@google.com>, bpf <bpf@vger.kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, Alexei Starovoitov <ast@kernel.org>
Date: Thu, 28 May 2026 20:03:40 -0700
In-Reply-To: <CAADnVQKfjaro6PMyd=2qaU9UeecLmTbzfj-f5ULUpfobhsbUgQ@mail.gmail.com>
References: 
	<CAA-VZPk5=sQMCkngpXBo34v6=Ut5YmxNiTKSLfS6-GiSvUZUEQ@mail.gmail.com>
	 <5bd0c7b135559943f3abccda6390705da5e493d5.camel@gmail.com>
	 <9d1dc36948ea9cfdf48f643f9b34ccaf51411847.camel@gmail.com>
	 <CAADnVQKfjaro6PMyd=2qaU9UeecLmTbzfj-f5ULUpfobhsbUgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-28 at 18:05 -0700, Alexei Starovoitov wrote:
> On Thu, May 28, 2026 at 4:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > [2] https://github.com/eddyz87/bpf/tree/cnum-split-at-zero
> >=20
> > Approach [2] fixes the issue at hand and has almost no impact on
> > verification performance when tested on a set of
> > selftest/scx/meta/cilium programs.
>=20
> pls quantify "almost not impact" and send that patch.
> Looks small enough.

Here are the stats comparing current master to this patch.
Results are filtered by programs taking >=3D 10K instructions to verify.

=3D=3D=3D=3D=3D=3D=3D=3D=3D selftests: master vs experiment2 =3D=3D=3D=3D=
=3D=3D=3D=3D=3D

-rw-r--r-- 1 ezingerman users 504K May 28 03:21 selftests.master.veristat.c=
sv
-rw-r--r-- 1 ezingerman users 504K May 28 03:07 selftests.experiment2.veris=
tat.csv
File  Program  Insns (A)  Insns (B)  Insns (DIFF)
----  -------  ---------  ---------  ------------

Total progs: 4707
Old success: 2952
New success: 2955
total_insns diff min:    0.00%
total_insns diff max:   32.41%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 837,487
total_insns abs max new: 837,487
   0 .. 5    %: 4702
  20 .. 30   %: 3
  30 .. 35   %: 2

=3D=3D=3D=3D=3D=3D=3D=3D=3D scx: master vs experiment2 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D

-rw-r--r-- 1 ezingerman users 38K May 28 03:22 scx.master.veristat.csv
-rw-r--r-- 1 ezingerman users 38K May 28 03:07 scx.experiment2.veristat.csv
File  Program  Insns (A)  Insns (B)  Insns (DIFF)
----  -------  ---------  ---------  ------------

Total progs: 376
Old success: 351
New success: 351
total_insns diff min:    0.00%
total_insns diff max:    0.00%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 233,696
total_insns abs max new: 233,696
   0 .. 5    %: 376

=3D=3D=3D=3D=3D=3D=3D=3D=3D meta: master vs experiment2 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D

-rw-r--r-- 1 ezingerman users 234K May 28 03:28 meta.master.veristat.csv
-rw-r--r-- 1 ezingerman users 234K May 28 03:14 meta.experiment2.veristat.c=
sv
File  Program  Insns (A)  Insns (B)  Insns (DIFF)
----  -------  ---------  ---------  ------------

Total progs: 1540
Old success: 1448
New success: 1448
total_insns diff min:    0.00%
total_insns diff max:    2.08%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 666,036
total_insns abs max new: 666,036
   0 .. 5    %: 1540

=3D=3D=3D=3D=3D=3D=3D=3D=3D cilium: master vs experiment2 =3D=3D=3D=3D=3D=
=3D=3D=3D=3D

-rw-r--r-- 1 ezingerman users 16K May 28 03:28 cilium.master.veristat.csv
-rw-r--r-- 1 ezingerman users 16K May 28 03:14 cilium.experiment2.veristat.=
csv
File             Program                            Insns (A)  Insns (B)  I=
nsns  (DIFF)
---------------  ---------------------------------  ---------  ---------  -=
------------
bpf_host.o       tail_nodeport_nat_ingress_ipv4         19858      20170  +=
312 (+1.57%)
bpf_lxc.o        tail_nodeport_nat_ingress_ipv4         10510      11457  +=
947 (+9.01%)
bpf_overlay.o    tail_handle_inter_cluster_revsnat      10857      11437  +=
580 (+5.34%)
bpf_overlay.o    tail_nodeport_nat_ingress_ipv4         11768      12729  +=
961 (+8.17%)
bpf_wireguard.o  tail_nodeport_nat_ingress_ipv4         11811      12769  +=
958 (+8.11%)

Total progs: 134
Old success: 134
New success: 134
total_insns diff min:    0.00%
total_insns diff max:    9.01%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 152,012
total_insns abs max new: 152,012
   0 .. 5    %: 130
   5 .. 10   %: 4
