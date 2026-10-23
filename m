Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792792041;
	b=wG8/u9G1OvTn+h/Ue94w4LzbN5JvO4bBtdO5d5AQV1Gg7uFeUa/1u4kSHVpTsExHSUET
	 QYQymfk8nspQ2mROUNCR+VtHAqlFd6+SxvfubtoD5CiwigKeeCguj1J33rLGfTkBPSt4L
	 h3kPdxYEYjBhB8nOECc72P3BsMxPwNdWoqJx1vqr8iiCSSgRQJKMe4JnuOofrERGmCEVp
	 7hOdBNUup/7OHiLrm02Z1vhe0+V51V+1m+6xKiPygLuRfPY3M4zgdoaU088aUCiSId+Co
	 CRm6A9NKjtEs6xZL6bReozqDrBZh8EIuZk+nPSIz8Do0egs1nStc8IK/q2/Suo2lyqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xPSo9ItcVa4fj2ri5oc6bVUN+cUX/ExSvpmY9Grzytk=;
	b=0FO8t7ZOpVHtNRQa6zg54V002K7wkQPRACRXJShP5AEzSwH5sK5JyzYkuHh0/OVXsuNv
	 wdL0xDcpAJG1ZmdKP9E3NfHDpnNcBMDnHGcL1Ie/A7CGdpFQ+nMqmiocm+uEmErITj61p
	 bppsJgmP2AJZau/LjqOBI1KPWCnOyXL0BspZlI1FnKysRcTAVdXi3Y95WrzlYvFry9l4H
	 4qoGWllxAQDhpPIVMgWvM+IbyqYR8AB8RzQHvKznIPB//OCdUrQWjzel/KUDQtoL3EJO2
	 u3jQREnTpq1ueddicCJlCmITqJdUr0QcjlzJxr2Tlp1UjdMpe+bFzH2OieWDXP5TexQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hLDmu77i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF6D606A31E
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 21:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAF6D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hLDmu77i
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so721587a91.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792792040; cv=none;
        d=google.com; s=arc-20260327;
        b=Mw076PBOnky5ooDBUTbxnCoacf/xYl+I8oGOp3yOwx1Hg68CDaiUZLRTx+4nPp4WXB
         m3kwvPaI46zUqG0NVWM544lkYQeMExGLAUCkZHkK45i2uvx/vDNmiW5VOTMTg+qiU9So
         mGEMWv/fzAIND30JxMNtlfpU1GTN8X/Ctj0iaRgNuowetfe5aVHcjzwyL8U3HWOTZ68y
         qAKIP4kRn/sc1t7icyU1bejlRhHUGgVRkXTMlrWHVox5sZcCiYMWddiyMuD7O+pMZcfa
         2eJ7Bu4UyUQ5FOIWBnknmZ1YYgHosinx/BGTt811Tn71Sz33Tj933EZp1oA8VZNT8jpA
         IK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xPSo9ItcVa4fj2ri5oc6bVUN+cUX/ExSvpmY9Grzytk=;
        fh=N47WTb2B9rLpCzJJeHseJ2NdKM38+YsOAEzG+wHkKg4=;
        b=nh8SAf7c6qPfYu2sawMmOxPOx/T8IorGzpwfBHarSvh0IlnuTW3WNFLN6OmNMbx//C
         IPfsxEC1L9k2ORz9kDfxp6SDmPjeOlI2GISOKi+XspfVv751WdGRtoKuC2X0PB2eiiWY
         VHYArLwRCr2QRf7BOyDKXg2q/mHjiwt3sJ8j9Gbldtd+uF8OB7ZWWiNwM4bQS03naayp
         0tRiNxNn3RgqDjRmwXHLuOtDPgW35MbjBfQYyyiqzxhmYoT/l9TZGgnNLSar6QhPCz/Y
         QaYOA/epMOkXH2x2XUy3rNV5HPmiI35J0E10c5n8VOFpN5q9xAWUOvlDWtsjMGLycldI
         /njQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792792040; x=1793396840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xPSo9ItcVa4fj2ri5oc6bVUN+cUX/ExSvpmY9Grzytk=;
        b=hLDmu77ierYiamVgBV5vcAPXLaG8aupRNyDiDX7DkFNKpzAxzPIc63o3dmGM4zJaa9
         4NGe3YwDiymWhnQ/OCBGllsswfzcFZye7tQgoEq0wKR8ICoXlpOSA+BkFePJ+1A4Qtfs
         5B9uWQyifczwR83ZzMfzQhkVojser9lK+7Vg1COy1KYe+paFJC2NeFMJ0Pwj/pPj/iD2
         gXyhQWok5F1Qlv02XKngGqq1rGnm/5QhU+mrMgvZNpLlK+CJNtiedln6Mz0k16xq27uZ
         SIpi3iMCyeGt/gxH2+Gr5wKnY0+0nxLC7O7+qOh1rB8DPqu6rw1b+PmW+IOO7JtIQdHd
         VdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792040; x=1793396840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xPSo9ItcVa4fj2ri5oc6bVUN+cUX/ExSvpmY9Grzytk=;
        b=F/3qN6rAHErVTz6L16SkaAtVzpxn4znfAFW6iq0jyirCX5sZbhSGcpHv2MHyCsSkTH
         rp+Mjwh5RJTyoXjB/YGTMyFYEu+ZnhhOXwUAbZ8NbmfjRs0wmwzgeN6WfsN4bWgZEMLG
         cSaExs0FSAQs06rb8ia+q/Ux5RlNFy6DmbumuVoer3qX7l2r3T+Do4XfBVb23qmtU9gN
         f56ofR8GaLt0jp1hZfdXdPu2lk+98oLdWQBv3A21oi3o2EL3uZbp6FQESFBuLti2L/ya
         Yb2sOR7/rGq2B+GN9+LKm30hMQh2eXKWs/eiwwET1sFpkW5x1Q0LJTJuQZRZ7ZQyvq8y
         jTiA==
X-Gm-Message-State: AFq9FYLLzOABArisUA9uxJ1YzQXvFnROUi4NL84jfin/FewMQ//9lGFQ
	8v57CN9Fid85AS4W+BIvItYWmffHOLvbaLxyNe4mHyT+SGlExrwucEFTA8WSG7rfL/0dFVXsmND
	YfVR1ocnnZ4pqPvEsvL0cY8QsrTgbQkI=
X-Gm-Gg: AYBFou3Yl3AdVTOiIvSIa7ScBrP4qfvw5w+R3v/2VekfJp6gBvvh3/XXD5CsdptOMGm
	EJTf/085DS1pFdNVITgfqKmd45TRP9o5Zu0ghDQIvgz9SprZwliwGtVGIj7H83fs1co/aXpg1lV
	GDoX4yxVkJqrN3Lqxx4kGxfAE9dF+yJvSY6rp4Zyxu8S1IodpIAbvLF/fU7eVZI9sol7PspgIYO
	IHUQceE8DWlshv8fGdBTdwpfsKvunsowwzcVY89rtqlNmopxiq8HXb25hHAjFvIyz6y1OHcMWQG
	JmKJEL2aaWMjeg0nBPSVcfpeLjpSkt0ky2EM+kLF2WHlRtrxyC24GM4CGRiJsOEf+RR85SneY9a
	2jRH+dgFhyK0Wc0mpy51hE9/9AXvsmlzUW4Cl/C6fSC8rHD5Eb9yYCFucCrdrVFXhkqAyQQcfAC
	EBXp1/dRFutz1+AcCSAmuyaaecUk7/X09wLLjaPXE=
X-Received: by 2002:a17:90b:17c1:b0:3ac:8af9:4a77 with SMTP id
 98e67ed59e1d1-3adea8952f8mr420926a91.10.1792792040157; Fri, 23 Oct 2026
 14:47:20 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001072449.1377267-1-adi.sharma@zohomail.in> <1a168cbe0aa.30b7e048183449.4003649852775097641@zohomail.in>
In-Reply-To: <1a168cbe0aa.30b7e048183449.4003649852775097641@zohomail.in>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Oct 2026 14:47:05 -0700
X-Gm-Features: AclHuK9klZKtZiNDzc9m6HVwMpKUt6CjANLrIawUWNF0dNjLjk5PlT3PLx4p-yQ
Message-ID: <CAEf4BzYveiSZg0qg5h=EPiMQacnSXwp=8O+x74FM=89qrHV4=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix bpf_send_signal_task() from
 kernel thread context
To: Aditya Sharma <adi.sharma@zohomail.in>
Cc: bpf <bpf@vger.kernel.org>, andrii <andrii@kernel.org>, ast <ast@kernel.org>, 
	daniel <daniel@iogearbox.net>, eddyz87 <eddyz87@gmail.com>, memxor <memxor@gmail.com>, 
	"martin.lau" <martin.lau@linux.dev>, song <song@kernel.org>, 
	"yonghong.song" <yonghong.song@linux.dev>, jolsa <jolsa@kernel.org>, emil <emil@etsalapatis.com>, 
	"ihor.solodrai" <ihor.solodrai@linux.dev>, kpsingh <kpsingh@kernel.org>, matt <matt@bobrowski.net>, 
	rostedt <rostedt@goodmis.org>, mhiramat <mhiramat@kernel.org>, 
	"mathieu.desnoyers" <mathieu.desnoyers@efficios.com>, shuah <shuah@kernel.org>, 
	puranjay <puranjay@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 5:46=E2=80=AFAM Aditya Sharma <adi.sharma@zohomail.=
in> wrote:
>
> Hi,
>
>
> Gentle ping on this series.
>
> Andrii - patch 1 now removes the nmi_uaccess_okay() check entirely, as
> suggested on v1. Is this what you had in mind, or should I change
> something?
>

Hi, yes, it looks good to me, sorry it fell off the radar. bpf-next is
closed right now so I can't apply this just yet, but I'll apply one we
can do that

> Thanks,
> Aditya
