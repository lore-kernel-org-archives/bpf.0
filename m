Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792477428;
	b=JG/NSDhFzznMrBVrEPFqvtj3uPgV02jlQi4dy3q/xK3bhmkmY1viPsN0vXay9AAQ+Nt6
	 YWQlHebERXiotLCyFyOgBdxkaamWgbcYC6PSnblnUBR2H122Cqu3fCRhKXdOiTl1udoVq
	 yhgPr/hoNKvsy0bbeEDI1IgiMsxrdZnnMSJzm6tH8+eRXFK0M64Q6dJN6BvV9BnUgDu/0
	 QenQj8zxRa3WCwpdDsXWtJ9O1eBpmstSf2R7kpKYadbWZbotZhvl9Nhp8+xvNmrQWXMSq
	 +9rfwSIEuXou4y8vm3YYChoSeEy/TuUty56evw+mqmZDI24C7zbm0Ihy9a6wsptBuTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792477428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xY+9Gua3JjZJP919O7FVK4aXbXShPehswYzBc3Kq9+Y=;
	b=u7R/L5J/ftfy+1e9w46hhcBiSJ0kd3nafhBy2ouRTfGawKKuOErNzdVTbSYW5gjhB2Kp
	 uQaSg26Nnh8C89VURVVz3V5Ml3ErTfUi906OEdSJ6UKnMc0PL9mo4cMFLpMZx9n70GHbM
	 VgPl5dIROZWVPKI2iW2qbBLTUACZjRl2A5LhBX8vhDOVmzvXj3eCDeDuEoXAsUUI3uLI/
	 Ae6ulBPVM7Wb+UWJ7Bnm9Korv2qIsu6qHTwj8N0ULCAsw/WLHDpyx5H8TRqmgCHZMSfEW
	 N4HeRt+RtKkebbHhzdjhVGkT6zoR/PL8WZ6PUgcRHyD0OwXyPqGIFH4uDiD//3Qs8Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UWVA7zDW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB1606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 06:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8EB1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UWVA7zDW
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso2476108e87.3
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 23:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792477426; cv=none;
        d=google.com; s=arc-20260327;
        b=HdcO4dI1L68LLTruxFIZzKkCuG43bpCnS5NSMnNV6/CdvnAW80SltaIHnWQ/JiJS7E
         uD9lL7ZlRQXk8uPjDt+4X7ppZvpaHkO34DlUgwYfi5lRrULCN1WFeVOXsqIx+eWUmd7B
         QNZCNhuiPP3x7/Q96HoOXi1Y2LngpZ1Q5SSfYzCLBpXue4ALk5ejvvO0MBt1t+pu6CqL
         Smxu680ZvbnW6MDXoPaGrP3qBhG9sgrsn3zuxEIsfB2oYjPhhULEyIm6yEnDDN1GZtOL
         08HuGK6RrGx2yRrsBMdGKl7DhD9wGjZOKxbNMW8z7m7yKHFDcz1SOE0dZrdZWf/191NV
         e1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xY+9Gua3JjZJP919O7FVK4aXbXShPehswYzBc3Kq9+Y=;
        fh=6kyDZqYnF9CuMHZC8/5p0szuny59EmhFqTH7djeARyQ=;
        b=glZwafaIeZGwKdIebqOYOxpAithxN+0igfbZhDl2a7SdfgwAWp/oq759M2dEImVcQU
         31oDJGe0iBwFK7OtxhU20RHJ7LqOwFf5VkoBVGvsmEsuJ09dtjrW2nyQgY3Wux0E/ox/
         8shDWIAjCX0ruMW2MdG8S/pXRjqMbbrJkiRwjRtXK8/1IEIbUJIPfQ916ZV4v4w/gjBS
         tqJ10SgBDXPBB8UQOQeWfe5WFyuJy16kwvUQgXJaqRQxzYa2RMXPSBjodlh4kwmQwBts
         HFA0+c18Nj88W42EvZZR2euyhoZUKCiPuMM2n0Zw+4FapIbdMicTKfOYzLCI5pbys5Ns
         mXUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792477426; x=1793082226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xY+9Gua3JjZJP919O7FVK4aXbXShPehswYzBc3Kq9+Y=;
        b=UWVA7zDWow5j3cWA0r6ymLJXpdx0XwjnuBe+lZ7X2L061n0fnGuBD1AVqBAKeKMglN
         VLgIWUA2RbuY/fG4xjAmYsu/8zvtMxm4iElSgPRxT8aTB7ZDPuzgRUJlBQxHphUEd83m
         g/fBTauy9EAEjTXD0favegnkvkklGePd86UQBe75srwgVTQESwZjsQEi9qciwJQghdRQ
         tR7LJTH36tp2QIVbwsQlXrhDBfUUhTJLibLfncY9+f5bxkjUpOn23Epqghfu2rlKmF3v
         4cqV7o0595FIZeSMRJd1w6UjyEUc1JdY/7wyCgiymOyvG6ABMcr00qEUxsCy56chFotX
         FE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792477426; x=1793082226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xY+9Gua3JjZJP919O7FVK4aXbXShPehswYzBc3Kq9+Y=;
        b=d1WooVYjHkN+/+aCPsB0cmTO1ZJYdGiGSj25fCfaInSsQPsrj1qrM+g5vS+fxqyUm0
         7pH2I0CBMaa/d7totgoAqHOhJQU6SMECsiM8Zf/9IKhvHtHMLnB3sgEUHPupi3W5456d
         Ip/0TLT7xd/1F8WysM+NtMNayh1XnDmY+vaYIIA3W2uCkIto9ur/hpS1xw7UJUur76xm
         1LSsFocEY6P4s5GG0R94vuR/HsbO4c2LCilsEBB5o7rdt+n1hsOWudlJm5E1nr9/XYpL
         g7xOirK2YN+OSVPqyPkG8azxeldz26JHrd+rW/gZpqfNqbaS4wYmJxoCKCDBcWvH6aty
         Bcuw==
X-Forwarded-Encrypted: i=1; AKwUvBxw8/vahA3AGrcYoI7GFfW84G5ePRPS81Pr7euLJprPBBBn59mC2DFRjX/EUUlB7dK9OnQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNdzVO2CSMLVm63PW7R5RMk1u58jHPTy2Yp4lTdnXtmH/3CS++
	qWYcyS85w6b8topVz44tyVfjTKOYlSFXhdoMLDCeW216xukxS16uwgaf1E7xqcIRkCacUsfkVRr
	ycVhl9IOXfjBF/8x2ohA+h2Gn1b00GpU=
X-Gm-Gg: AYBFou1nU2q3imcWvG6Z1u6aEFcOAYiScKT7fa+sMJfFyfTpAPUWvC3ZshLTwE4mJ4o
	YNi6TlWI60zmyHz25gFHrwvPfKdlTgHFt/il5V2ElkYbmOYgZbEbUcSXU4smnu0P6GGbPWBZkcP
	LtdAkaMXgYUFzXVQ+6AqRaNemPhctJjrBmdd45Gy3+JQ6yjzW+2RJYgkQRNZkGv30qQ90zqHF7a
	XFvtgcOq67kEIVdlFkP30SYQTf0iRPdbmgXZAEsVSroLlEFIU2Ja8hh9aWNChQLFAXLn9f5O/ZE
	sbsY4fkIS/MfKNHxwmDPIuqftep0JL55dJNub46Z6iZ7rqXWGpHZJbMsf5HOxxCgSF76ud11g/z
	Z815XfL/XZpfNUSi7V8OH2jD4f8cX4cOYOUcriX3nM0G3CH6VXY4Us/awDKw3wJ3gQ/vaBQ==
X-Received: by 2002:a05:6512:10c1:b0:5b8:f4d4:7ff4 with SMTP id
 2adb3069b0e04-5be50a74cc6mr2861942e87.53.1792477425787; Mon, 19 Oct 2026
 23:23:45 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019082214.102398-1-dmantipov@yandex.ru>
In-Reply-To: <20261019082214.102398-1-dmantipov@yandex.ru>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Oct 2026 14:23:07 +0800
X-Gm-Features: AclHuK8JKD5Z6WDYyq0TEA6JyqRSpdqT95b7DSefRKIlR8POo1NdSXaCNKLZsDo
Message-ID: <CAL+tcoAyM0uL8UWqYMH9=bCrLwtqorAKHqm=v1tQ95p2y5AqBw@mail.gmail.com>
Subject: Re: [PATCH v2] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Eric Dumazet <edumazet@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Kicinski <kuba@kernel.org>, Levi Zim <rsworktech@outlook.com>, 
	Denis Yarapov <yarapov_d@mcst.ru>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	lvc-project@linuxtesting.org, Sashiko <shodan.ai@mcst.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 4:27=E2=80=AFPM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> In tcp_bpf_sendmsg(), the value returned by sk_msg_memcopy_from_iter()
> is checked for error but not propagated to 'out_err' label, so error
> handling may not work as expected. Fix this by assigning error value
> to 'err', thus making sure that error won't be silently ignored.
>
> Reported-by: Sashiko <shodan.ai@mcst.ru>
> Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
