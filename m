Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA54326D75
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467106; cv=pass; b=sgeas9bCqdQYNQ5oUEwQmH9Sz5NVDi5z7+Li1/iDRMIF/LBwnwmJBbVM7LzMVS76TcXXqAgoFFqGhVY5qzj9G3um83ljE/eWZu+IaemHv0DArZBjLqTvggY5XURR9X+hc0aN2Rtvk45yItpOaNjrHWwnXzpr3dpz4ebcsSvSV3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467106; c=relaxed/simple;
	bh=/TPjtAXjXkz2ScoCpqpIUeYNfC8HDnwi7bbiTfsh7Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSci/YqFGvZji0iKbEErprRKFBxZGjGT2VM94jNVbWtfGSCFzyLy4IlQOrZRWqQQYrM977vdl4RB7wriVKAM5T6Rd9MNWSyJ5mAwKLWV2hoAEplhG61+ZjX2uMBMW2VRfJaBts6xzSZB5AnQPmPai0yp+f7sWtWKsQ0i1efrg4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfuPH7t0; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfuPH7t0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b6d9c981so849977f8f.1
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 07:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772467102; cv=none;
        d=google.com; s=arc-20240605;
        b=EYG3awaflTJf+5Jk2OAL/s/AZlDkQ9TI9nfSpFcY6l51toP/t4O0CKOntZMkAfuNUm
         pZ6jOAWox8dANNgKwDgHKCQi+MQ+EiANBsJdVhgYjjzx2lYXO44GAsoU/KEqAO6FMBV0
         qcEROmSSDTR/h7DeGtcQ46AErGrIYReN3XeWStah5eYxeTitEo5MoRdNO2aXab/Jlx8f
         45f8b44DfmKIrKiOL/xu5dhzWBM1Cc5R69duj0ZoA+DS8uXsmWgrQlbeCIELaS37RWWh
         VSDq9PEnE8vRa8y3cG4S4Mt5MiabTTUaOEjONMk4FTV4aeVcxgXUdm8rLvbjluuqQ/mR
         E6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/TPjtAXjXkz2ScoCpqpIUeYNfC8HDnwi7bbiTfsh7Uc=;
        fh=1WHJdLqE+1nMz7AVQZ2NPa0v8mWNpr0bR1qaNquatbM=;
        b=Glukh/476MF2CSrak19MtKpieGIzHHcCSDU55ykknoBnqveUFX4B0O5zwzjwfP29Im
         E+22AbjiRbrV4gBt0wHQ6x56Hh4xd/HfHLiCnGzchtED/EaBm10qx/UNqsOJzsAcFE52
         QPBQENq5XbcDwB+zztzDCMWaO/GK88i09b8zmIIcJjrXoNurmTFPHXGJKp1/vmd2uXV0
         KCNF5xXDUgvRtyumHXp+dO2xrqLY2Je1d/fKR0nPhU9WVfSgBdZ8PGXgbvnceGm3uOa2
         bDR5+FO6onPZeJq8CWgwKVpRQ044BI4ecraOnzDjxV620Kn2NeCBQuxpw8D5UUN2Ly+2
         DTCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772467102; x=1773071902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TPjtAXjXkz2ScoCpqpIUeYNfC8HDnwi7bbiTfsh7Uc=;
        b=UfuPH7t0fBUoJU5kJwx/P8nMCN+9gGWkIdbsQDuXFVdN1K3pG88zzwz+9mtk69kUVn
         3WcRJ2z6Dhlep+CH6JpCjGwGD5yW0HgfsSsLU3JktluhEo+XE8J8Ckm//B6iTdo465yr
         u6J3l/HvP5ieEuovV3TNwb6893zFm1lXzL9GA+wLmlbToJs2wwm1SIGP+1hc8sH9F0Uw
         aChdtDvhWCODglEd9nYI+EKaHkQU2foq60mW+ru2o9JHKkpskrwh1/+5wC2tPnXWADIo
         e8xNComQwhKlX1WwD4Yz7KzkGMOfWY3lugL8YjU1bRsFBH13WlY3Uqq9NLoS+kFSnalb
         RpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467102; x=1773071902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/TPjtAXjXkz2ScoCpqpIUeYNfC8HDnwi7bbiTfsh7Uc=;
        b=dky06fLD/xtoj3KhubHgyHuCY9m5MRJCZ7HvkAPOugw9yP40y+wzyZgM/VvAgR+pQx
         5vVI8A/u6iU1BC9uivsOB+7mAjFmi5t9h0VjGkeTmNMiys73/aXW2NMwqBWdHW1ShFAo
         sxMicN6boSWqdsRZVS+tL+JdIE0re6WVaBb03hMz06tUld9ok0JDCqo2h5U7SamiAeAX
         NviyP2q2Tadt7bXClz2azAcsV24XjV+3+1mwdbhj+AF5CtSjz75xZPIr7Poc21UK/Zcq
         Lh+jVAKNmxUtSVdssN221JKGDCoU55kwOxs+bk0x5xicLaSH4300eiZiYyPuB6Y2Bmcs
         7tew==
X-Forwarded-Encrypted: i=1; AJvYcCWrAvzlqORxhhRJGfj0MpDksrJjzqap/10pbfXU+FTfZ+pYKvj/onLsl48lUVchhKeFfhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkcuJCqrO2XxAM3WgxxVBMaeZIhbfBKGI7o61KxnRlw7ibgPNl
	RKxtpKzKY1JglpuUkOOTZ1QNApneqXZS3gPR0Ktk5C3IvoHn+n2INg0lMju79VuQWKft6lnO54G
	jYH6C/T1ECFCpgj6R7ynnOvfU0iuXyh3N5Q==
X-Gm-Gg: ATEYQzxqAINkdM4ZPos/YSgSWdzMdhMIPun0z8DMKJ5PLpn76VDXQudHbb2Z3He4/Ky
	o7Iblhtqvx/KhKYVz4ecmN33HqH03LSrjZrlSNUZHKpIazXRRa/2GV6+mEkt4YrbOHlF56tkWgA
	+2zAkJ13jKuLxXutgY+5KlKLWuFYuqyiROOiEa8S/REWRGkiTEcj20Y96lFr+Ephe6y9i8tR/t9
	7Sbi4yOJSL5RlqdXWBcMqMOUYYGwId6MKpJsQFuQI3DvgGlV7TWQ3lxGjjiTqOn3AmIDsHC4X4G
	PTpuNVtBQX89fhT/lUkwSjLmSWPzSqFbW+2RIF2wi1sMX/K/oy6ru6iYIZuNghFNIe/meBq1HH4
	/Qv0MVg==
X-Received: by 2002:a05:6000:2411:b0:436:3761:583b with SMTP id
 ffacd0b85a97d-43997204715mr29586238f8f.27.1772467102344; Mon, 02 Mar 2026
 07:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302081622.165713-1-jolsa@kernel.org>
In-Reply-To: <20260302081622.165713-1-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Mar 2026 07:58:11 -0800
X-Gm-Features: AaiRm52_d2IDD4Or5e6YvBC9gr4AV-b3oFE-DpqVFN7rfeGBIt28no9bc-gd-cs
Message-ID: <CAADnVQKBx71HOwVcRFj7ja+y_NL83rpKQ0BRcismOwdCNx6pbA@mail.gmail.com>
Subject: Re: [PATCH bpf] ftrace: Add missing ftrace_lock to update_ftrace_direct_add/del
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 12:16=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Ihor and Kumar reported splat from ftrace_get_addr_curr [1], which happen=
ed
> because of the missing ftrace_lock in update_ftrace_direct_add/del functi=
ons
> allowing concurrent access to ftrace internals.
>
> The ftrace_update_ops function must be guarded by ftrace_lock, adding tha=
t.
>
> Fixes: 05dc5e9c1fe1 ("ftrace: Add update_ftrace_direct_add function")
> Fixes: 8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")
> Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Closes: https://lore.kernel.org/bpf/1b58ffb2-92ae-433a-ba46-95294d6edea2@=
linux.dev/
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

lgtm.

Steven,
should it land through ftrace tree?
