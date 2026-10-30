Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793390580;
	b=5Plvo+BaE0OozGTyTrA+me1sljcyJK83L9h7AmrJyn6SkCMLMmvrmBrskAat6Rx4ECu2
	 3+mhb6HRCq+aF3PSA+VKfWKqARHvY90mlFLy/+8PFKSuqaFoANr8hnk7m/S5pYFETJ+eX
	 KKM5XW085I4PIwUMteFM5fQhFbBtTgLABFP5MNVEep7P1snBVnQB89ag2Yf5qp4rZkOnK
	 aqsGjrbxRzCOa9F6YYhjM/Eszj9XicXTMhme9kWFPAzmNgtR/kDACU/8umc6vt8STcbtS
	 PHkEE8jGDudj+s5f4i/C41RmmG8UrXeE8V5OpuiU59Pf5mKGjfiSdpm6rJl1MFFtFQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nbenqoNggPOGuK4qGvw8vJitQbUecGnq+5smM7bEIBU=;
	b=ghJh6P72lNwdQvFADhmKc3/o2mBjYoA7O4FGGbsQgQ1fvqUqez1l7lHvi8Vu6XWTzwpD
	 LSzKqsqR2B94yYDoET5YM+cCDzx51U35iHivYSoLi9wZUQV1BVcLluAQwlACHH/21W8Il
	 VLe8pnsu871JW7Q6sIVFYIQiGYtlK/g1ZNAAIb9WY3N0yV3ucx6Qex8x05a0NZrMm63Pp
	 qzSGlssG6YIK+bIJI3sHEN7fGBrobdAruT7fznyD/7PQLIBYUSi9lJ5eCy3pkiWzoQZ4+
	 HwlaxIJOT1Jt8ApaFi1I/m2yVqZsymPdfecgKBfoP1ZW77F+Uiurqo6Yt6lnAOkgNIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=su5zxmIv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4D7606A324
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 20:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE4D7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=su5zxmIv
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso772052a91.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 13:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793390579; cv=none;
        d=google.com; s=arc-20260327;
        b=XEMfiAsPsJxrEGpUDylF2ZDjhBXyZdhPlhEmh/+rfstG37OYU5GoXEqum04EfAhbKx
         zXFtAFM5WVbFuhCrJt0BKoOYewGeOK5s1kgQPRjD77ITVZzctOaSrrC5cshW63KH6a32
         lyWPh4ZJUVR7Wew1n/SDc4Px4LJbVDUebjaT0/bRqHqU2F5+o5NC5sLxcVGNeoVTE1YT
         HD8NbhNtJRXt5NJc1EcCO5YOdcYUCdCggsC+s7tm0H1uj7DwuA2x+i0tuzHkYjkBQYNM
         FqSykYS4+RqtDX+jY3xVqSNaOpQah/ygnVhPqXQ/xB8FDDPzl4Gj8qZK6UPRAC3GtQvL
         /MBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nbenqoNggPOGuK4qGvw8vJitQbUecGnq+5smM7bEIBU=;
        fh=QnpM+1/kzR2vDJ3jl1GOe6nOdSMWQ+JNfcjcUoMVk0I=;
        b=U3cGm3B5tsnay1cwKCloVHu7bPb3v4MCzxnnkBRmdnu2RMbW48+oTuMKy33+kpLRT6
         BqvrjEF1CNiXUWTHaCGKuquiQcibLnpZkDS8rdbFOQ5dMDaYmcxW/74lTowGZ1FqXeue
         2ghSY55bHshZfv+Es6bn8zs+Dg3FLl4wZA1x1xYjGruq+PbfY7DCa47rCO01OIP/l/N7
         UHjjOwI1LswLQRyMKGDnA4FyoQWfpKniWS1v4BytxTDM6yXGGFgENuAkN4A8VY4tP8j9
         4oC7BlgoJI+Oor86mMOOuDTH+7y866BGKu4h4QfYFjhgXv/am28k9H0rV2NTco0yVAB4
         Cuzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793390579; x=1793995379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nbenqoNggPOGuK4qGvw8vJitQbUecGnq+5smM7bEIBU=;
        b=su5zxmIvmu1AjjCLpDSFUAIU7fLZKX0xQjfo/8LkAIGqgh3yzGqpVNlJ7400H6svzu
         VpjRXuQNDAIyEPlg2PnktHdejMIWrS8g3XeKyH40w1xordt93xlqFQy1LUv+UAh4cjL1
         THMHfWjqy6PMSxNjqoIhWng1w/URUEsER/4TOVU473LDiVYxIGBk/zFOIlHUywFpIace
         241TNf8fEUetetwteFjVNEPigRclBYld9zUAH7d/uCFE5dzanoDcpjnPMYmQiGGGX6RX
         qMQeIcDbVZSNdQhGve430T0bLiK2bPeHPqGPqiyVWasIVEDr3hnkp4kpRLWw+dzLKf8X
         klgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390579; x=1793995379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nbenqoNggPOGuK4qGvw8vJitQbUecGnq+5smM7bEIBU=;
        b=2jsRkrTmEdiHIagwJ+drpasSWaaZpNo2oDxH6NeMZmBfl7pX4yxeKOnturA5QC8fp0
         Ocv7xt3DLAwKPf70g9CR5s8Qy+Sf5vKegioBARH7+5bM+hBEXTolm04zB5dlDGy8sCaX
         e9s8GREtjys/AOgal9FAnk/Fny6YapnkJyJnLQM5V2OKepiNPpIdbqWPN/FH1Z3f0zDT
         Ztx7D2D1jWGB6xk8+0qCj3B+9MJ9RWfaINUV6VS21PmEgN9bVx8NGqqdHT8gBrzr9vvU
         YjOcnEvlz/cD69X1pHq7I63ByQhtshPjLie3Ye1+rRMEON7foU3pkzlv55nP1ebkWt/C
         bo6g==
X-Forwarded-Encrypted: i=1; AKwUvByyLobTITgPGDc01+4mcQR8MUlUXatwDQpt2NW6xsKUUQQpwbzbcDuPqwGYRFjYcVhopcA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtT2b9hDpN4lsD6gBdI1ihoFoxcbS3j7OF1ca3Pna7YhSDw0HA
	RXvuSorgnh+XGl46Q5KDYWJZBKKD7YTq0HFhGuTdhulzMSk1tM+ipie2ourTKXsPhc2l5U1YoTf
	jY4sypIAJ5TdGBsEnfJBm8OKaI+I7OKg=
X-Gm-Gg: AYBFou2/TM0tattthYt21C8QG7/xrHjFNhuCOrElZ4gjGvnYyGo3lneggRScliNsYIH
	OgIVUZngXL/lulp/vr1hNjXdKT5oJwBO/JmE/lyu+BvTD6PmHEhM9eJMBG4feOUl/6KjqtZ0DXC
	ztOICkHgbI5IkvO5ZNM8XzyP0aS5CN5UTC/T4JQQS+NjBlsS2rVGcX5OKK3ihCpTdb4ya5iqeD8
	Sp4Zz9bXClWCA86iRXpqGNxa7KIz5Qo7QdTNYck9F9QxSWsSuFr03guYqTHQTLnTt4bY0gsbWQu
	b09nAV66+sD/Q6vz1dpQZVvz8Swpc/zq67KC5Kfk4bQFCexdlhL8u1H8VLeEoqc7rrnoFpCGy6z
	zJDACEdCtdC6YQM/WNjuiNFRykEcinnfcfHCwJIuCNo+HsV/ETNeAHguAjPUr4eKLFid7+FVWaV
	mK9asae28ddT7LfBiPeC9WFu9TdffMWpuN3A==
X-Received: by 2002:a17:90b:5807:b0:3ab:be66:ddbf with SMTP id
 98e67ed59e1d1-3ae8981dd4dmr2709491a91.54.1793390579014; Fri, 30 Oct 2026
 13:02:59 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030090913.76944-1-dennylin0707@gmail.com>
 <CAEf4BzaMDRa8xD1oR587P82MYKCYR61gyjgvjKySSnnqFb27pw@mail.gmail.com> <CAGEkeHcq7HeecPyTSYuHWMhCyOAbF7br+UjrFfLiQmgi6kTxhw@mail.gmail.com>
In-Reply-To: <CAGEkeHcq7HeecPyTSYuHWMhCyOAbF7br+UjrFfLiQmgi6kTxhw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Oct 2026 13:02:45 -0700
X-Gm-Features: AclHuK_Wbx7tTAl_S8XFq74Lo6HCz6RCzxmpAzM8Agr_hE29nmfggcjLF7bCVLA
Message-ID: <CAEf4BzZOWM-v0f_25vNU2LKHRjco+nCYXYnQ0MxiQW8HOtQZ8Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpftool: avoid sign extension in unsigned
 enum JSON dumps
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: qmo@kernel.org, bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 1:00=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> > please drop RFC tag and report with Quentin's ack
>
> Reposted as v2 with the RFC tag removed and Quentin's ack added.
>
> For future bpftool fixes during the merge window, would you prefer
> regular bpf-next patches or RFCs?
>

regular, bpf-next is generally open during merge window

> Thanks,
> Hungyu
