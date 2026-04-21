Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D5E1E2614
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787856; cv=none; b=Sth22INVwjVDYpRlHAfY3rjEL1zOWqZWdvllHvfIIoddMqQIn7RDnciwsf+LT0N5/3GyZCndcrTgKC+CNHXG993rpbRgAo5vSams1Hb9GEMzWr8EgEE0UwTkCVYWoQVPkcOg+541bf0+4pJJTD7QrGXhKY2gm9rKYLkLpxCYPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787856; c=relaxed/simple;
	bh=qCC5hSOMe/AlmNbrZ9nLMkG3sz8wvkzb1FVsUePXCBo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fAoZcwSvWOAKQ+1DIcvnlfWdNLa9Pe37s5+F3JmL3jwbJ8wiX/MBDMfGHSIkxviQb1bNUVx2UwwrohRE7lKMOdWw1ocIQzhir5CSLw0n2LQ5J/66Jq9be0qhVkjKSs0XEvrFOeGRXecrTWIL2pijEcx2Hn4L/uFrr03knbYwCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv2ZyWvP; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv2ZyWvP"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45f053b7b90so2526952b6e.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776787853; x=1777392653; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlePGMUlJ76+PKDU/NhCfOzFaD2adBfoLGFykuoGKWw=;
        b=Rv2ZyWvPZl5gDECGVM2eIPeJsuulgnjtcs9X41ptwf+jo+EpH7hsm7UAMmlo1Ff3gN
         Yots2hnV0wNhmQQdnGF1P8hHzKDaP9mJb2lyapuRPji08lQMi9qJKIUZy1zluubcivTq
         nD+LwPIb3f+K263leSJzjg/A5HV0IODG+lBCdrvTf1FPEgsKA9JIiYFPG5+GorAWtLC8
         HvTvWuO9R4u4yTwO65YVewvEpykHl3ALZPxopkZlyCUkv8+/jhXkcMfE71CEH2DZxtgx
         Mto+dN+0AettrUlwwtTL3DDplRXFyjSI60iZHRXeV8xrE6m8xxo/N6/4NW70oaWdS2O6
         oBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776787853; x=1777392653;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlePGMUlJ76+PKDU/NhCfOzFaD2adBfoLGFykuoGKWw=;
        b=Sxj4GXU7cZ/soVk5n3j4gThAvJu9jUUyewrvdTXZvZ+Wsvm72JRPuzWJBSftKygO/q
         ZpMzTV7QiCNVdawg4fHHcBGSTNR2icfW7u4EPWxSoPB7AfDhV1uOVy6Es74Ng2RdxufM
         tHn82pV6WDK2R0iObIjtZiSM0OwgHd71TsglPYT3P/16ok8PzfaPe7KaxOh2THqvPVlX
         YyB6uE6i3MQZB2JPJswl/S0v39Xk9fpXm3AsrBjU9MDzA/R6THTecsY8c2218Az5jf5a
         yxJv6DJkkHIbaQswKhW8J6qbh1/fGnpwXb2/a+COgViZR+TAcasJi5qeeW9EmPnvr4LQ
         0rBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+htt27OImX65EBInXFsRheXMTJ+USGg84Hqx7jRBDtsNj7fdZIuyJGN7V4lwxmrp1CJY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHbeMRkqRGTP3RRYQPk/EKW7fphBVFOHskeSUerg2sW/g77zQM
	bK2UQ2L5XxopazxbxUbZFGzz0E0eRTeoJbBHoT83pFtW3D6OhRgbtNgC
X-Gm-Gg: AeBDieuG+FF8jVLYlJUBFHqa0sfmMlpGTZzNq32Q1wYRpvkmNbVMlm93sUy3CPpQw1I
	3FWW6bopZWo1sSR2OJGJvCZbfHqkCWabL5iMOB8e9NCK3ylnlx9rkjR45F2DOVk3g5S2lmyG4L1
	KttrJBMO4zmtCyPONjPI/kO/60j+/gQl5n212BuBjICDP4ErTAZzJeaAisNPPUgAwan+PKFg5yz
	5Ys1COOW7ExSep5TFHsbIHCv+6yW1+Cd0aCELrNxHmqvXSnXdiGBlAEFGl6TnOqFD7PsfYyTfYM
	P/ekJsjr28WS1C9GaFHm7hqevRlgrdSrm+AA5ykTKWeiT6J7nYz41VT41JvW0QSbIAYgpp35bIN
	aiGBu8y7OMnKzp9VzDh2sq4ZfC4O4KzpeGk5YVutghwgw3HKzuFxLKo0nVVmw7AX7JEYq5+IrCh
	jibDqXUBbo43DIe1AkRAOOI+xK8yLLiPmAsS71r8PRuID/ZeDM4XU4wbZmb7ZcQGemSXnqC0uKT
	KazBkRWoBe+dQw1ZM5w8MT81uiOFPSBnyr5U34=
X-Received: by 2002:a05:6808:f89:b0:479:f928:44ec with SMTP id 5614622812f47-479f9378c6dmr773316b6e.42.1776787853621;
        Tue, 21 Apr 2026 09:10:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd56bd0e4sm3243257a34.2.2026.04.21.09.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 09:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 09:10:51 -0700
Message-Id: <DHYYQ6F0ZVAB.1FNAHDCF3WHKX@gmail.com>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <shung-hsi.yu@suse.com>,
 <paul.chaignon@gmail.com>, <harishankar.vishwanathan@gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with
 struct cnum{32,64}
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>
X-Mailer: aerc
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
In-Reply-To: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>

On Tue Apr 21, 2026 at 3:28 AM PDT, Eduard Zingerman wrote:
>
> Debug metrics
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> To understand the practical impact of the precision trade-offs,
> two debug counters were added (here [3]):
>
> - isec_overapprox: counts how many times cnum_intersect() in
>   conditional branch refinement had to collapse two disjoint arcs into
>   one, losing precision that the signed/unsigned pair could represent.
>
> - crossing_poles: counts how many times an ALU operation produces a
>   cnum that crosses both the unsigned (0/U_MAX) and signed
>   (S_MAX/S_MIN) boundaries simultaneously. Such cnums cannot be
>   represented as a pair of signed and unsigned ranges.
>
> Across 6683 programs:
> - crossing_poles fires 551K times for 21% of programs.
> - isec_overapprox fires 119K times for 12% of programs,

so cnums win 551k times and lose 119k ?

>   most programs have only 1-5 hits. The bulk comes from a few large
>   sched_ext and profiling programs.

and most losses are in sched_ext, yet overall it's a win:

 scx_rusty.bpf.o  rusty_enqueue         39842      22053  -17789 (-44.65%)
 scx_rusty.bpf.o  rusty_stopping        37738      19949  -17789 (-47.14%)
 scx_wd40.bpf.o   wd40_stopping         37729      19880  -17849 (-47.31%)

> - 801 programs have crossing_poles > 0 with isec_overapprox =3D 0.
> - 202 programs have isec_overapprox > 0 with crossing_poles =3D 0.

similar wins vs losses story ?

I think even without wins we have to adopt cnum-s mainly for memory
savings. Once we move to model where do_check_insn() is a transfer
function the memory savings will become more important.

