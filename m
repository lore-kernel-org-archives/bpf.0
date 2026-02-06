Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC22D8DDF
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399570; cv=pass; b=e/v7vQF5vx0qdclbwz4bXs7XY/snsI0RPpRZY7O3KOu7LQu5wiYtZXNkhKXmK4xLQ/giAEA/60KPRaO2sQGUQyk5PlpuBRxerU6LxcPpDrgG2nVAQfQUoabojeI8as3v9y8lLhNsjLCMei6Tm448q+MQpl4Nt+1K0W2Z8t0U24o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399570; c=relaxed/simple;
	bh=/xcM8rEuq6wU1HRmAP2pZXXwStrfQwI5eVL19g3QaqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJUYs30UXthKRAq+WP+y/imDvA0FwMIUlnCwHELXwf4t0/9Bvv3/DVd2HW2Fhvz2Ar80JbfDiNF9q63Fh1mufU5snbJ6CCmoqfMnbNfZHtfJueCORINJ/towahrOTTgT6z3pdXOMlrAWTERonT7x0ityn4A42XLKk73cfRk+XOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3MXZ1z+; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3MXZ1z+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso15697335e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 09:39:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770399568; cv=none;
        d=google.com; s=arc-20240605;
        b=fIFEsiKPHFMwOOqduZUxViOJgKV9JKRqWGF0hbmbTwT5xaNGE+xix0jSKm2lGiHTte
         fnJCvVz9uTX/Wk8unMtm4llPjQUyVAf0LYgcs/ySB2D3Z9qc1LSxHmFbP9/J8v6mLwD0
         LCaYnCeTMFeGoPrPLhbxQN/EDLw4qeUvWY1isclW4ugBpH3Dk0zQ2adMc+bu6aoQNIAO
         zjQAHU9VoHGp+nRhtKa08buzXfNSNU8u8d1/3Y6GQDwGfj7pd4ihqiLeMiF/tFRvhpXm
         8e70JdOfL63FdOzggL78FDeV3VRpDLj9SJkG1W3yq59WmCuhphRJtFhgDcy6BVTWZeAr
         1Bqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mxsEHElmdVyhBy8oLH1GXCMKsnKp6WZzm6RxnoWSNrk=;
        fh=C7/CMszcZeBLhzPW7KGgE3eLFd9TKfGz5ZMvT5o8fyo=;
        b=a+XERdDorj+KNRlE+epoxMV5ocAi5ltCpLCu0R7PAFIsjScDfPeiUK2w/V6bKXZtZQ
         qTL3kX2oH2DRBNQpmqKfP0lTWq4q5uBRdq7jT+4xfHNq+nBiNrSP1IuilERyRNulfhWB
         V2Ifj2nYgAP/dmYAPz3pMS85eSlkGVa5ovTrKefAzmsB4L2Eo9QmR1S+gbUoserqfppZ
         clza4kydUFDWCNrTPwlTwFye/4v5zRH0RnKEljXfBno2BMumZ5q5OkFayFdQzhTJ6cHG
         6YAxHrzRJSiilI+IXicbgoPcKZzXuRm5cNyATipAXDVEX+Z2MdtAV+yHD71xnCqetfnI
         jAkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770399568; x=1771004368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxsEHElmdVyhBy8oLH1GXCMKsnKp6WZzm6RxnoWSNrk=;
        b=A3MXZ1z+QIIwhKGNQ08W7aQoPinyGSMRGyC2ISaAv1LWAWuFGJEXCEoXBg/6SdGObK
         fKcM/Dd8qcm7+7VyyI8bNn8QWfe0uKVLZRzGxMneej/JEN2bqIm1zFCbDRtCFYt/qAGH
         lpxseLVXotWO+fksTgbG+IBmA3nZDmPFPZRylMIIn01u/Hq3rVQG2cMrmTytn1RT56vb
         8l5qSeOgHtxWl2WwsjXDkGmZlTUNm3TajcTP1f67j1clb18brqZ6mnk2KHwTPKcrbcTd
         FBuFHH1sV1Can/KH6GiCwREqr1kkwePWLzgkmBNXI/qu7jFMW/fc2o8EIux0f/XvOuw/
         0xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399568; x=1771004368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxsEHElmdVyhBy8oLH1GXCMKsnKp6WZzm6RxnoWSNrk=;
        b=jft6Mw1iLbScaNFSP+NRW9oTOwmqLL0AKtl8kfA23SE7uz72R/ejSJWwJLtwVQb9kE
         JyojFBChkKGHZ1MvtbZR4vxJBD5LQIgrGfbmIBhQzXuLQVhmPlYYPdCpi9agYSNE3V8s
         KR5gSFpE8funpScmzltw0tQZoO5S98txEzH2KRsv9cGGDV7VKEysFcPWWaJgj0I6vdze
         O+cnVMoaVdR/O6AWg7OZyss51KxFYl340FpAvTJFBeVgUUrIlOZqwk4iZbrDAQksVXTr
         jFl1bPrhOqycosSis1RhJgCVUhb2UpWhE344lK2dy0vorWRuCs+IdvLdAXWw/s28HqNN
         +fAw==
X-Gm-Message-State: AOJu0YyujpELizYlvwNHjxwTtlIwK38as7owPdbUvB7aH3sa2+dV9bOw
	Kd9GfI/KEiDz1U06Ei3MqmCph/zO51Xl5XUguFCf9z80yPM9CpSGnYnIr6fyjy/vmm9FhoS8V/T
	TVCMv0nIGv+ecUm7Hj3YPWgKc5TqtLlY=
X-Gm-Gg: AZuq6aJIoZQl9+E1aSKLXLKqq9YDoq2AGZaDG6lfde91Z5gDm1I0P6aczwYS8oHPblA
	PZpEaCi82BW3kWk1W4i5Q2RxCE58zl7gRuE2vk3nMen2zpI8L+w7bM/aoGV+yR2Wz/ntueDg1g1
	OWSCCOk72sqkTeEdu5AMtBihtRcTEfqoQ7Eo5kvUb33X81fEFF6cy7tE7v8TEe/N2U4ourgEDWU
	JsxhUBaEI3ztCrA5MB7rxmRlvuN1O0TG2YGFVsAyZlcPHKiwzh5Sv0tKB8xn4lZ5EOl+/HzC7Qa
	ns8Cb0EEOYk6124KEq+Ms6WAJ6ABfehJKM5KVKJ8oFmsDGKivBPlUGdFJpy+W2CGnqsRaewSPqg
	PsbMZsgZN5o53LQ==
X-Received: by 2002:a05:600c:6209:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-483201ee840mr48075395e9.14.1770399567976; Fri, 06 Feb 2026
 09:39:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203155103.2305816-1-larysa.zaremba@intel.com>
In-Reply-To: <20260203155103.2305816-1-larysa.zaremba@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Feb 2026 09:39:16 -0800
X-Gm-Features: AZwV_Qhiudu9I4yt9_TPQJS3OSxaKo3Vh7XUGlL9nFcebbE8dzWA0vJPdWwRON4
Message-ID: <CAADnVQLszbJ=dMjmAVkj1zGBPhhopU7XHH6bc1UHEemXwbgxzQ@mail.gmail.com>
Subject: Re: [PATCH bpf 0/2] Fix some corner cases in xskxceiver
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>, 
	Jason Xing <kernelxing@tencent.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 8:18=E2=80=AFAM Larysa Zaremba <larysa.zaremba@intel=
.com> wrote:
>
> While working on XDP and AF_XDP support for ixgbevf driver,
> I came across two distinct problems that caused tests to fail
> when they shouldn't have.

Applied.

What is the status of kernel side fixes?

Running test_xsk.sh I see plenty of

[   93.609026] BUG: Bad page state in process xskxceiver  pfn:115920
...
[   93.633927]  bad_page.cold+0xd0/0x140
[   93.633929]  __free_frozen_pages+0x85a/0x1150
[   93.633935]  bpf_xdp_adjust_tail+0x808/0x1120
