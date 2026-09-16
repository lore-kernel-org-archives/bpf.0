Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAFA4E1C7B
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592582; cv=none; b=U/pCnCrOBAoVO+w2vtoSGsoiSiEBDoyJDy2kKYfZvh1ESYeEsMayqYPL2m1lljEuAflsT+B2Zv/nNhlcidI9tSVQFoxcVrLjDPAYz99h84BhAPii+qD+3Sdo047SxC+81QIXqGRBZW5Bl0s3h0saXCxKMpE96qKyyjGl07qga7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592582; c=relaxed/simple;
	bh=t6Ey1Skts6LhNlHmrxVnF5Fj2sFH7x2b3BqTdVz2dII=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=d13XAalwp2pzBx5t7PqqiJWiCu1EGswwiXeVWXlrpJnOQtAM6xzM+dzfqSD21WHgR+dMc8lNN2mlhmq+8OYNuZEbXiq+qWzqFWA+g/y1sx8vN71FcDmgXb32UKbvXV8mJx3ZEMahh2el/F2cUBHwC8/UQYKx/REnbKPVt+/HNgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmhXPK2+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmhXPK2+"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso87228a91.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789592573; x=1790197373; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v0PiPkE53/kByahLJHuGHd4DXMGbPCcWOf05KFD1zLw=;
        b=WmhXPK2+YfmrBfZDX1bHDCsWxW/ON5iq+qY75gxkJIUWuV1g7Tap/+bJJMQec/cDCa
         wXZ/McLcYp/n3vlNjKf8iIYggO6sj5ypGzUONZL3EE/hcj9TyIYX94Na3AUkIOK+7KY/
         CjBKs5ipq7/i38aQct2wESba9bR0wfSeNZCJCkT5JqKcPB4nDA3lkrMtBoHIvtHiwlXJ
         10xH0SO+fxgod70K4VjbstOd2PFsDDWvX2BxiESLlOcrLzgrpgQzlLQciel4ZepqPBRJ
         zCsxxrymL4yLkrGP/9LYZIbxvXHM/e8LzlTtZL/5X3ZOZKMuAeE86Mwt1EVtV5nPm3AQ
         GSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789592573; x=1790197373;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0PiPkE53/kByahLJHuGHd4DXMGbPCcWOf05KFD1zLw=;
        b=qF7TrVdh067GFixn3oI23oS9SkDaqwxSJFqhYmUFUI7YSXYv+LyP98ajZIrp5W+Ida
         WMCRC8b9bpH/koWLnnIBJncCQTJm7grxr56lbDcAkoQWjkJgUuYbpGKg8ashwXr01/U1
         6EGabLT9MnyB4PYwFucNcC+ZeSTe3FswHmqPl+N8MX36WC3/YdBTRzzDHnXd4b0lLbEP
         kqC/r+1JPGzKn0I6SOHRFYk4wVZKem1jryRc83hsoDEY0PQbdvkCXaOmX1Rny5KZc5tZ
         jHAj9ZrZcE+wElXp64kkviotuzYFVoON0IwzeTNDoQAy8TZ1cbNoUFvoPx5rv1VXhStR
         xAMg==
X-Forwarded-Encrypted: i=1; AKwUvBwTvD+sq6lXzyxDthEwxq/qU4WQFVjixFg5eJDVb+TVpE1YL7rDEfopqfVY4coM56qWXWg=@vger.kernel.org
X-Gm-Message-State: AFuF++mXatisQCbSr1ZGkhHO/pJouejvbSuQ5UU5XNzmNgy5C8I6VPiz
	KQBrB+vZLECjE/oVT5U3jlXeoZ7Pd4s4m4Ydzp2svTERF1vljY6CNFwl
X-Gm-Gg: AYBFou34FCIxVZrQicuI7hV3/Wi2CKEuV1Uu9q6WtgMbQNVGKKGQ8Cy+nxkorFncPzu
	VmeaePNpV5+zKRbOD08btB8BVwSyG4lsHjXntkEtZ5x9qMbBOnbsVDNOaiAyqSjs2PE7tE1A8Jh
	ry9DxcdI/7wFiyN3n5PBYAm3QUULNvmlqbZNBbzsDrNu18m+MIopaVdACm707pLTe6hjBSBhiOb
	KJejNIoiRrObwquHGAe4ux3+RNlGFgGsx5FSQGJdssdwgQAT96cmHyv5L05Z/fgc6VGaft/wg8h
	25m/D1TE5I1sFhJ0dtMv29NtITL5sIblUBW5nCxCX3feM0xh86wCiFyGfxGWm/sJpz0BO61M2Z6
	fAxKIIWSWH7dBzMAyv/sFtoPj/CGAEb7qa/C1xfsq/iixsx38jV/BDjD1Rcl2Ky7XeOXWNz2BBt
	QxSHqvRL56oot0KuP5zIFdrL6ZJTz20FWpiIpw0A6OjBC5yJMFfL2FdhjN6r6a4sAIt7oRtMPjm
	rsjG0XUZjoiJMpm3FzbY9oI8xHUGWZWvs8S+x6v2C2j+5obVGp1HJGCwK3tgZRmaaUGzPiUAo8m
	EAP6h+QFhHU2k/COdYKd1e68CCkOXpOHJhmgV9g+K++xIdRiPjtg9iMU
X-Received: by 2002:a17:90b:4c88:b0:39d:f024:c7ee with SMTP id 98e67ed59e1d1-39e1e56637bmr8836686a91.25.1789592573141;
        Wed, 16 Sep 2026 14:02:53 -0700 (PDT)
Received: from localhost (ec2-35-83-186-167.us-west-2.compute.amazonaws.com. [35.83.186.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35e732d6sm1163831a91.11.2026.09.16.14.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 14:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 21:02:52 +0000
Message-Id: <DLH1MDZPU5G0.228555JR34D3N@gmail.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <john.fastabend@gmail.com>, <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-2-vineet.gupta@linux.dev>
 <DLDKB6BTHVXE.PFK87O3QY1J5@gmail.com>
 <f575fe19-a5a0-4f43-b1bd-cdec2c6e9830@linux.dev>
In-Reply-To: <f575fe19-a5a0-4f43-b1bd-cdec2c6e9830@linux.dev>

On Tue Sep 15, 2026 at 1:17 AM UTC, Vineet Gupta wrote:
> Back when I started, keeping it NFC made more sense. But with all the=20
> nuances discovered in the process, I'm inclined to drop the NFC stance=20

What is NFC ?

> and make functional changes - there's at least one which is the=20
> following accepted pre-series and now rejected.
>
>  =C2=A0 =C2=A0 =C2=A0 old {r2.id=3DA+delta32}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0vs cur {r2.id=3DB+delta64}

that's a red flag, no? The refactoring patch shouldn't have
any changes to selftest and veristat numbers?
Unless I'm missing it again.
