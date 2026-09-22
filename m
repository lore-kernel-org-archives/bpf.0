Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EF40BCB8
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118541; cv=none; b=cMX3nLsOx/56cmIaD0XNUIoixEEmpRNr+FV9LJTG4S1X3v/enkBOu41n6PKrIL8Q8LFNbgK14NPum2CXeErVKHS75IsKdtDtstfbNzaHFcw9kLUvA5ySBcUnhhU3Vx08CCdr1s20bRhpOyPLcflUDX/BPIw1ZhFOW1DF6wc2TEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118541; c=relaxed/simple;
	bh=gYG4G+mttOpRdZ42grlU2zuBUzBzODittM+9dw3vwAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYbj0prwTH88KVbRNspd0WyUfXzE8h4dwsFfpcUE9xX+f00JsF65jW5JnOJIuc8qaMcUzIyZXPhWbn0BiInWRZStPNRUkk8X4OixtrtvMkJbFZA3TRrpXSu/TuZY0XoDZ5HUrrgD4wjjXeaQcwgUZacfgPXVKCu3EgxsqAoAr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fywyLVBp; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fywyLVBp"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd025d07so288141c88.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790118539; x=1790723339; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gYG4G+mttOpRdZ42grlU2zuBUzBzODittM+9dw3vwAI=;
        b=fywyLVBpajrxHTXkDtq5Zq6/NIqi+UBi23Gs0E9qgpEckXAh7AYLbM/aotWTo+QhdW
         qfRySVvVAHWlhVGCY1tRmdJKSXbwYCfvkmRApq52/hWaCLSRKXJW7/MZQhYNdoxew9Z9
         x8MNAH0jDpXhxpym1RIq62QJYOmFVDcGxgL0ONn+5bQZJp7OpX/czu/GNhFjBZQch5an
         In6Tess9bnpGlCBisU0gobADRlg9wRH9kd5dl4l208gGS9AtIXd1JwHVxOIwyU+yNw6k
         Q8DhgcL6wnqE3hS5H5sg2BhhaewDwnWxgNwX7a3/gA0uQ+m/aTAewOwFW2LJ+htosFXg
         swPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790118539; x=1790723339;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYG4G+mttOpRdZ42grlU2zuBUzBzODittM+9dw3vwAI=;
        b=Em4gSxF94irPqiLNOqGwcHUyzRhhNf/2HGCpoCycRgrSD7tXmPReoncuDGXLyvJUES
         qHaLA3oVZFf7CjifPFQPvH2HBoVtQZkGDJjTWsWcx0OzQ6pVs0olhWH9l/NMmKGL5ySI
         92SFHAAXYWY8NhpneHEquFZ3rMTR3qNq6JBk0KfOLJUw9LIIzMDZfDsWLTdJlbO8BIsq
         gCPibgm+8skH4VSMHO7GRIG1XoCkY1zjaNXXcJ5viK51OqcRqqEMWEJC/HGem2aJ98lI
         HD17LU+16klsPygaeNM9hRIvVBMTdKw3kJteq0Fz52p1NpeKO2LPT/++4nQt1l95Te6e
         J6ug==
X-Forwarded-Encrypted: i=1; AKwUvBxs7h3+z9MaZv7fotz6EyY/Gxusa5bP1kwWjeuBGYD815hA/B3h7xVc2oVgSeEC1050TKs=@vger.kernel.org
X-Gm-Message-State: AFuF++l5x/NXzS/OlrysogXEh3hjofSf7Gui35m1bY43/PGn2QCVao/o
	PwI141TTmpwbyqi9baGNUttcky4cAQvouuzfXZL6kSD0HjLcwhh492B8
X-Gm-Gg: AYBFou0pkRueVn7ndg0hMbj+tCyKQ5yLtFz7jH0iCWhu0Vg1QKWazjPHGKTnGEGMg6e
	Bq5HGg4mXOrDBO+LZ499XmI/yqmwBdVz/k5/Dna0lmGoJSdEkLn0c7oCdfniEDgBs0Z/RzF24l9
	z2+itSwmpc8dYpiYEj7msBK/EM87y5iRy/RUrIyhhOPn3lrJ90K/lU4W8o7Jic0rxNR134KFkRu
	bjGDE8wNMGPxK1a32Sq/O90uEj1U/NaK9SfXUctu5X3KOBlBQWH5Bsh73FxNNjjl1+rQ2T+ANp3
	pFxpe8zOvKK+c46zMgpIqGvVwDDqtAB3MXR4vaKCvldmp3jbZbqOklGk520T3bEjD7A9TriQ55B
	uPNvRVFLJ3sJ4vNM7iWGBiYa+74OFVub+OFDHHSXX8Z8+BvekZBM3hIbA1FymJb/TL/ZLrzXYNa
	wPATfm/WBfZ5Rdd2+a7y5oX65qVbcQADp8zmSCMpJc6qzFNbBuxo/WlARqyXpFpfuOWDpLphHZ1
	I6/X0uDuqkfxA+bZQGC3cQ/jaMH+L6CVnxzY4DWWWSgW2r4bnSeofQo6g==
X-Received: by 2002:a05:7022:3b89:b0:143:490b:93da with SMTP id a92af1059eb24-144f917a192mr1004895c88.39.1790118538997;
        Tue, 22 Sep 2026 16:08:58 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f4d5:5623:3480:5143? ([2620:10d:c090:500::7:fbb7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f988342asm1194044c88.11.2026.09.22.16.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 16:08:58 -0700 (PDT)
Message-ID: <37e53199dfda608de30a31fc51d22ed2b25d6d2e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 22 Sep 2026 16:08:57 -0700
In-Reply-To: <DLM6BVU1G0V3.29T5BPPZTZ77Z@gmail.com>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
	 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
	 <7eba4eb055e15d5c78f463d013fa98bb21d7b494.camel@gmail.com>
	 <DLM6BVU1G0V3.29T5BPPZTZ77Z@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 21:47 +0000, Alexei Starovoitov wrote:
> On Tue Sep 22, 2026 at 4:27 AM UTC, Eduard Zingerman wrote:
> >=20
> > Total size of executable sections for all Meta BPF object files used
> > for CI veristat testing is 10Mb. Of these there are 30K non-helper
> > call instructions in total.
> > So we are talking about increase by 8 * 30K =3D 240K ~ 2.4% worst case.
> > Note that the instruction encoding optimized for size already hearts
> > us in src/dst registers department: we have no room for virtual
> > registers, which would have simplified e.g. register allocation task
> > for ARM64. Point being that optimizing intermediate IR for size is not
> > always a right target.
>=20
> I wasn't talking about increase in bpf ELF size,
> but the amount of the verifier work necessary to double the number
> of call insns.

I don't understand what you mean by the amount of the verifier work.
Traced program paths would remain the same, only the encoding of the
information about exceptions changes.

> > As Kartikeya says in a sibling email, I mean generic verifier
> > capability to accept any program by introducing runtime checks.
> > Verifier's capacity to infer safety conditions for various
> > instructions is orthogonal to rustc's assumptions about landing pad
> > boundaries. E.g. rustc/llvm might infer that certain memory access is
> > within bounds and optimize bound checks out, it is not a given that
> > verifier would come to a same conclusion and that some landing pad
> > would be declared for an instruction.
>=20
> Replied to Kumar. I don't think the verifier will ever insert
> runtime checks with control flow at random points.
> If we teach rustc to insert may_goto then it will be done
> at rustc/llvm level. Not by the verifier.

Fighting the verifier after rustc transformations would be especially fun.
Do we have a working toolchain somewhere? I can work a few examples.
