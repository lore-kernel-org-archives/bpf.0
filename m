Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774E1DF271
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696950; cv=none; b=sIotSv0ClbZsFQ9NN8UfZiaJX4yI+AHzv3QPpaitm4qFcM+qQWG2fW6BtoXPLY7dKm44XPpSNqI6ry9wHetyI43UkeBPIp4mDC1pTOYnAVjpFP0lfrGRDUw9ZLSq9feHPNKWuKa0exkxCD1xJRYUJmf62COXsMWaZUmq4j/4eTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696950; c=relaxed/simple;
	bh=Y2ydpJMk3ZlWBU6AhADB5LMwqIZAStXoc5F7Opp4G7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uABc10VT+OODueVifBEF0afG1pYvo8Y7tHbDzwr3z/fnkIr9/RUxDa4CsdATV23fzSSSHKFPeyBD89NxGwf/ppJHbqBfw/ZUfpkXZMrMtz6P3EMmjGbyoUVN8LOU1Fl8PwpSXc2lQOsVFxKgWhiX6Zv+EsofXBB1mHW2SlyUqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwsreuVr; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwsreuVr"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5709396eec.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696948; x=1774301748; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y2ydpJMk3ZlWBU6AhADB5LMwqIZAStXoc5F7Opp4G7Y=;
        b=KwsreuVrHGql7J6Ht2Cvl3N/TmlCPAXhrnaNgzqPweEyTCvs1Ip9NJ4Ps3QhQx2PE0
         j/84O7mh7wbTqadFBAVABbBfgnqd+whth+vnHGQ/Y7WsSxx79Ttw6EQEODrvgbse2rdN
         R8ZccGaeJTY09LFgPHiqPcLCt3IGMLQRSi+SHueJHKvrHpLnDZDk02gRpzUWXMtBF9Ot
         7GMRMfWCOaF/tkglCMz17SwxJwc/PBBx8nHUjDwxJp54Y1K9QsU5dXq2hLt4nXy+3BIE
         ghZCS5eFdDlkjDxR+bw1icAw/G0L2ThXsPg/Pjg0ZMSHAFlOoID1V3uDPAeIOO/cQqkH
         a9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696948; x=1774301748;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2ydpJMk3ZlWBU6AhADB5LMwqIZAStXoc5F7Opp4G7Y=;
        b=AD0FQaOpHRUwXnvTx4X1ewjOa5NUiOcgudRnH4DukbOPCMA5CuK4RDDQCvVs/Heu88
         EeHcPi+zC24//7XWlIkYHooLjM6j09qmfZnRWbhP1Q3bRlGkxEkYzezheRcb2MQkHgh8
         1ioarBcep8No1fnVQlRONaur40bOHrRPcDmxF1LEhQVnY6MltE/cB1CKqb14aeC3fr9H
         AnJIppCWtwZHfcTjHg1L7MGUcUrVNfJxYyTDUDEp3juLnxYxDHTUVb3SwsD8Pehu/Ojb
         Sb8gohE2xTp8QZBtPni60oXAxK8rNR0nV+V/Qy/uBNPnTycDuXorDK+nsNKO/XDZ2Xu9
         dlqw==
X-Forwarded-Encrypted: i=1; AJvYcCWkXsAVLKD1w1+N92Dsf4zdFcG550mqWZz3Ni5EBsUrtwG1q6SDn/8Hg2wRa1sYrwEVglw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1fA6tT0UbR/1l07vgkbcLw+yx5LR/CwP9TooGmIksNZjMvseO
	BLnFrQMx0Wg/j+4vYeTNcrU8p5L54OyZQBVOjqhtnGmP+5mJ7m/GaCKd
X-Gm-Gg: ATEYQzxTKQ539q3UWCOwK2ULdT/SX0NtuOT4Isdv6BVUxieAy7S/BiikyV+r/0eL6VN
	EHRgiOjy45gZFW4o/ehLPS9Tf9vWT/gxfwhfDSBNxUcyqJFloqyAacoBZc6abRLBpDQkxd1ORGJ
	iEjRRFtzoKim4dH1dR3wu5NT0er6VttgisJYR+tgpp3l+oDMPuc2YkVX84B8NhOR++JM11HSYRL
	23CtgEY5Ak5Up/URkGG7WVDXHETatHfsAePhdbtUx5NLUbYzHLQFudRu5cQqkHwXw4z8Wsvn5DV
	Sxk56HjEi+oPxlEBlENbim+WUpjhOwbn9UnHwaNV98Lp26hNnIm3CnDWV8ol2o678ZgtZoSaIDO
	lYhdmUFO32UsDFxv5ZHYzjoKHhkm8FA977MJKYwlvGUw4MkgtzPfZE8h/jjlN/PZ5MC82hj6YgC
	cSukeDfHJacC7fjXcMiGv1xMGsBwyrR9p7BOZzVnHkCuxj6ok0ZWU6q/d9dnc=
X-Received: by 2002:a05:7300:6c27:b0:2ba:8706:d022 with SMTP id 5a478bee46e88-2bea54de53emr5565490eec.18.1773696948153;
        Mon, 16 Mar 2026 14:35:48 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::7bc? ([2620:10d:c090:600::76f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0bfd41aacsm8878081eec.27.2026.03.16.14.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:35:47 -0700 (PDT)
Message-ID: <26897fdb11234b8dca4cc6700325428d63847d18.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 02/11] selftests/bpf: Test passing
 CONST_PTR_TO_DYNPTR to kfunc that may mutate dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Date: Mon, 16 Mar 2026 14:35:46 -0700
In-Reply-To: <20260307064439.3247440-3-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
	 <20260307064439.3247440-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-06 at 22:44 -0800, Amery Hung wrote:
> Make sure for kfunc that takes mutable dynptr argument, verifier rejects
> passing CONST_PTR_TO_DYNPTR to it.
>=20
> Rename struct sample to test_sample to avoid a conflict with the
> definition in vmlinux.h
>=20
> In test_kfunc_dynptr_param.c, initialize dynptr to 0 to avoid
> -Wuninitialized-const-pointer warning.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
