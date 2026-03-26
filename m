Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD641C2E1
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543794; cv=pass; b=pCZBlMU4BA+gg0wLnb8o9lnxc1wpETDLHsVuCPst+ewujfh9Ko+6NpoxYZzj7xl0XBqa2LBBCNkWb1UPUZluNhywfiPcGo+vpYwUduYOCANYDw/pz0tPGEHiaFvldqb5/Z39mAHMl+pGoS8jJLki+iCaWxEQK+yR9DzMc8HERnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543794; c=relaxed/simple;
	bh=mwuGUto8viWJ8eWLjElTofUP2sQx6PXZWoM1AEZ5Is4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koRd8axl4TUAjNELh7Yepgvdwji9qViDxei1KA6s3kZuBPb2ZkaifsXMEK1lIXScYWC5M3kcL5zLzh+fJY1iXhn0AEXwAzErlsT1pVzZX51rg6Jk7u159tXnxy8ccNp/Y5pTXPfcsKTQBkaPbbdoTeYUZUwsMzicheLFyZGSQBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRsMBLJB; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRsMBLJB"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43b5bded412so826172f8f.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543791; cv=none;
        d=google.com; s=arc-20240605;
        b=iSmYbCiL0dh3RawWVF53a0sVLfAWWGRLDcd+JqkWfJjHf+Cgot1OzybA4fzWz8U0Ej
         5vUwLEXGQLapING9ZNtPJPIFevQF3aJyJB1vq30yAZdKGjG7+3MpPhfZdJ33z943ylKa
         MxkwdX5hkDBTWiez8XP72ZzzGrM4vi/LS1rs0IuT0j8A/BizECl0hUrYYRQ7dLDPz1mx
         TBFxmGnx4r3jIMys6cbOjFaVvBsCVD1cqtz8PrCswTuE4Zef5aMMkMz+bCTnLvrC/qnb
         twKKkPfB3GJ/20Uy0cShJcLLX/pWDsTlz2kAutFFWYxPCoWUEat0noCISMUkt7c4FG6S
         t1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/fjWjhkwlFGKWFZtzYIffsUMrKbhXLKuzpsB2elDRf0=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=KnhaFNYS8yLySC/fqzGJ5dLZQ6Jz8jop59WXA8jE9EVCte/4aYFvIYoaDZieP5ZsWM
         k4QS5hggCSQTJO2g8tZatbNFcsylY0R07kG3tz4wHIgMqbFlq7kc4yJNF6THsVG227yN
         sUE/QV+jTrhfKU4W1PmoYCC09D56zIb4G21sa1kFHalyUnK+pMBhC5KYkMgPtZKo3IKB
         ktDs1+Z7mgw5tqVRhGojrVxobZoEob+kUS+HME0V1Y4xKM659I5mXjU1fsWSOFNj7m4x
         k2om+3LUISpRArHntL4Vw4HK8gfiaotVknd2BYTBgWyujhe+BrvAhpTBTNVk+ykTRPa/
         81IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774543791; x=1775148591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/fjWjhkwlFGKWFZtzYIffsUMrKbhXLKuzpsB2elDRf0=;
        b=sRsMBLJBgx802tW2LC58g03EiJ2F1ZRZkIBv2ckoyuKJo3088HxJ+zMG6cUD2vfC/g
         LWGuInCB0ecHHnnyDm0cLYJp8nC+PCrizxMXt9cF77REnpGo0IQfL0f0I/zMVnPZv+m9
         77om88QJxQdsj/JuFhY+HIKx8YEcPKsN4Dlrm0g7HB9hc3ESUK/IC6GtX6/4nYxRSFzv
         MYjVZAFemMgeI1LugQGf9YETcjRDANXC3onvYVvDVZrxvUKnBsL9Eiw7r8qFtEVOhrqM
         1Rn1CGM8PV5aYnbNpsvVUEET/xMH+zIKTW3aGXeUlCFJHdLOa3Mv+JKyGcHPWvIpgSAk
         OZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543791; x=1775148591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fjWjhkwlFGKWFZtzYIffsUMrKbhXLKuzpsB2elDRf0=;
        b=fh1iYgGPoNc43uUn794J3AXkGpR7fnqgWVBGnsIvkqzHAUcLTD0YD7KMuhPX5bPvlH
         JL7NpDpyczJ6Y82V4/WRs8Uh8750x02Kayz/0q1mGp2xFg9SEqQmFbnKemylKvz9K/PL
         JxiPO/T9xuM37CAGO/jpVsLgh4Y0sTzxOsrX5hV0JhOuDNIgRxWFk8Oj4C11hJmrIK2g
         KEa6WAZ8Q1kHX87MOlTqjDx5W2KjmplJqHe9l1Z0JNfXpcLPz1JILuVdQ76OFodF/2k3
         +6x56VI+3NefjfWsAV306VUnBhgz2PuPAlzGHq81v89+5yU/yRPjks28cCzl2keSfqvS
         eypQ==
X-Gm-Message-State: AOJu0YzMU0t6JT7TkdRblBdbYqq081dm2FwL7/KhHU+TbIzr3z54nQua
	/FxzX3QPpwV2WLZFiVgo29ZeXOiQcEUWp1eOl1UP71qr6nPrByJMVCZPZG7NzuX3tH/4xABXqoK
	0GKuTdylsR7fYfDtSYqomnBFJtq6tWqg=
X-Gm-Gg: ATEYQzwSLLNIaH8gAO5JAGV3boKxRS/j8j73FDkUi1aLylLcrqv3pqRJ/HN5clW05P9
	TeQEdSXyMOTzGow+tg5vdAjtPyBrvIBKDKDcxsbbqyS85bElZ2Lz5AnXximg0nyMhYDDh++4fob
	uOY/8OdlD4kMp8vYWug47nW+ntsQ9Q2Z9n/uJz4bHsSeYuk+HcBt0NytNxZLa6iVAS0ikxSuBSx
	cC5N6FkA2DNCLI6MMqbuuJYmTfC/k4wbQYWbkZNg6dmWg8HFKhUCykixf/HyY3Rh8r6Z1HGa7Xd
	cAR0k87yscLLEkjaVDCdzynAofKWgjtaD2slJRCRpTmQvjpyQRAx02oEk9Be
X-Received: by 2002:a05:6000:2c09:b0:43b:4980:b15a with SMTP id
 ffacd0b85a97d-43b889a8236mr12767796f8f.13.1774543790762; Thu, 26 Mar 2026
 09:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com> <20260325-sleepable_tracepoints-v6-5-2b182dacea13@meta.com>
In-Reply-To: <20260325-sleepable_tracepoints-v6-5-2b182dacea13@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 17:49:14 +0100
X-Gm-Features: AQROBzBkooiIjRjwexb2d4Mn5f96c4J42Op6I9b1-ZXTRyHl48U35aMx0ULpV-A
Message-ID: <CAP01T744EzO1tzOf1pKm587oamfkZTEAKfDwVe3t0yAOVrf9Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 5/6] libbpf: Add section handlers for
 sleepable tracepoints
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 19:55, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add SEC_DEF entries for sleepable tracepoint variants:
>   - "tp_btf.s+"     for sleepable BTF-based raw tracepoints
>   - "raw_tp.s+"     for sleepable classic raw tracepoints
>   - "raw_tracepoint.s+" (alias)
>   - "tp.s+"         for sleepable classic tracepoints
>   - "tracepoint.s+" (alias)
>
> Update attach_raw_tp() to recognize "raw_tp.s" and
> "raw_tracepoint.s" prefixes when extracting the tracepoint name.
>
> Rewrite attach_tp() to use a prefix array including "tp.s/" and
> "tracepoint.s/" variants for proper section name parsing.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
