Received: from mail-oi2-f41.google.com (mail-oi2-f41.google.com [74.125.231.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0072EACF2
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573090; cv=pass; b=bAN9rxRtxxCu6bh/gu/rb16BoqtE1CDoQF94hpstcCy7ylCnfqBV2I5/eZPO1ca1QrmZVwEjHzq8DO/JoD55EGcAEUam1bZgzFpKCAJ0EGoiDvGUJIXErGDCLVXeB5vrzziSKfB9ToUMLC/rUGbhaoIe1hT4Q+gbhCppXE4beUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573090; c=relaxed/simple;
	bh=C7xsBapVCY9iwTdAdl5LIz6ryDog5EsEERLNrkHEr84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nM6mmpHjVo++fQN9l9a2k+Sk4sEKJOXQm95fDgy3Bsp7KF4BwzG/3JlXWcxMuqEAQpfMc8O0UssZPH33UQsvFuC9yYgS5znXSg90GxYy/liFmfQjN3Mcd+jg5PFskNEHYNDGaA5kVVLQ+Ieyg8IkfyyyYdu0P2cqmKvyEoozVOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqhgB3/U; arc=pass smtp.client-ip=74.125.231.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqhgB3/U"
Received: by mail-oi2-f41.google.com with SMTP id 5614622812f47-4e973221218so504308b6e.0
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 22:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790573088; cv=none;
        d=google.com; s=arc-20260327;
        b=QPp7FIIVEbMhelJawCAWVjsXhPciVlDCiK2kz1eU+gHcv2Z8DN8NgOjssKhU3Gn/X7
         FB0PRLIXCRS09d9oyzOVoFxotBgTHMsJn/eiWIfTNmtK7zJsZbn8SPzPjdy2w79+qDAK
         aj+i9nQKk843CUenteHGjEgGYswik5320VhE9WO4jR+hds6+7eB6YlhXn2M8T/9TC+/3
         Kc1trWOd4gvLGFkcPCCsbNbuZOOWBLtTEJB+d+mI4KHH/fYIO9wFwIEuK0kTuVEhnzUn
         Un5e44OAdV4E3Rf/5F6fxadl4kP27PeoQ+tHs0a9GgA3wjFll0acfygoE445ik4ZOpok
         hwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C7xsBapVCY9iwTdAdl5LIz6ryDog5EsEERLNrkHEr84=;
        fh=Mn4Kp/tm7wGzuMnNO6K1cvcBgh/rlyOQShpIgHQn+LA=;
        b=Jaxzf8vOmJa6mfmRw9WH1hJRBSpuHvdnp4++tE2Us1mQC3kH8F8qgdnWrZB+ydq5Rt
         QUXnHvSYIOLBZXsH4ybWQbgy3mNibAbrnBlabZ8fsUqKftPyLhYrS42R7NxX2zofeGZi
         xfZs8SIfTS12+jTuLbQpvA5rFLjM45cfS2wSka4Djc4afxGGm7rGWUisRkgxsgxwZlHw
         S+n+j3HieDoZFre27RTBLUmeiHf6Te+9DX9CMg1UDhUlGnDUeLfku9H8K1zmRf/glWAz
         7ZdSPcauFY7mxWr3mPuGqCU5weGu6q4KM+LUK/uU+KBhAzAT7phiVX28ZfD6UsC1C2nJ
         3suQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790573088; x=1791177888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C7xsBapVCY9iwTdAdl5LIz6ryDog5EsEERLNrkHEr84=;
        b=PqhgB3/U652a4no0WwBi6wO7Q7q0z6dFwS0r3q4TClizdJKh7C/buooGzhDw3qAHPQ
         rH1R6+iwgKGWQFzSCfvtTp8OnPWRz6I+PCA5677Orw7FyM0PVyNNC8hdrbhFgUHjB1xf
         uXS8aYN6QodcEOZgBXIQ+pdcsrOFQpa7z6qT8Cr+pNy5axNO8Bd8RtQP/I8gmRJfgIoy
         /9BmFMgU2+qAXRJuQDrC0ksyynmog3NR0FKUXzUlty8MSOEjEQzRy7/I2upGuJrzTcZl
         UHCZOdszcfFXYU7r3irhJ82PRTCHOPOHaG3KxB/SB/zjPjbIm0nX2YpmShiPcmnJgogS
         JboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790573088; x=1791177888;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C7xsBapVCY9iwTdAdl5LIz6ryDog5EsEERLNrkHEr84=;
        b=eQgCWAswIygQpI6+TwtHBAOvZ6J5SAvZ9ubArbjVf5qushpAaKiLVNp5FTROlnLxWa
         bZ5fs962IoBnJSovEoDZw7EQXPRlQhIzWvUJVBp2G+lVr08sbXVpgsEXWeePl+KJgevr
         ZBMvF+qFGjKVcDN1w6hWTcRbrBh6pUUa8F9VVhM0aJQSdPY7xW750gTd3uLVTxdHd6ED
         gJuYYjm/sikRwaYdkq3T1OFpyqDuiALrGrRX6n6zoZ3hETnuGIdvI1ug7pPa19aCJPt5
         l45FdO1hXNi0rsx0YATHI6271TnjIhJM/GEBuBSVvxpJoskUvb9Veng+7JlYzWNK3Px5
         49Tw==
X-Gm-Message-State: AFuF++nFmC29PbA/7YsOohRH6Fd9gDrDRGPVRTfTYDvpXYYzFYaUPKAE
	VNe3V158HzAKctvlAyEnpfhP8rkChkuFFZ3FZZXBtJNYw6SwBhMVbj5QdUclnygPwS3edlveJRW
	xVvE3SPwyRL7KaXf/wVqK4XQ4qlthyOs=
X-Gm-Gg: AYBFou0MkYBVYj4z14r5pL7k/bvfv327AAddFCyduxOpBt7pctaAG9mcSRFWsbzo7I2
	O7TV0IMnT189PubTdimDVkC9rcPoW87xkftmQ/bz5t8j0zGVPYYWMY0meyo7SnuD0hhZomuYwSn
	6cxn9k2i5M56yk5sDniN7bSHSu1pZLfNXxDgzj6XPAUFLfnHBesADAnrzN2rZrEwy/Mu7sc8mqf
	jDSQLkBYAoZZSgYEt99vk+xgRriasETAu0MgLAiMwBEx34hFG4Zx+8YrkiFRZCrUTJO20OuVsmf
	XKqwkheZUVmhTQ5csSr2PNViYV4MBDSOq72NRrzAaOa0c1eFuPIBPhc=
X-Received: by 2002:a05:6808:190c:b0:4d6:9153:2968 with SMTP id
 5614622812f47-4d72b734f85mr15436760b6e.57.1790573087823; Sun, 27 Sep 2026
 22:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn> <20260927120422.1042107-3-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260927120422.1042107-3-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 27 Sep 2026 22:24:36 -0700
X-Gm-Features: AclHuK_SceCfMS80D5YwTg0YrFHBA_6JP8I9ts0GAP5-35D4F_DnxnNG588FwS4
Message-ID: <CAMB2axOqM3HdQhbv2_hjWXq9Ox2CmnGEJ9aBMhSK-AyTC8zdJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: Test dynptr teardown on
 subprog return
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 5:04=E2=80=AFAM Xu Yunxiang <xyx2021@mail.ustc.edu.=
cn> wrote:
>
> Add failure tests for slices that escape a subprogram from a dynptr in th=
e
> callee stack. Cover immediate use of a ring buffer clone slice,
> release-time invalidation of a caller dynptr slice after it crosses a
> subprogram return, and immediate use of an skb dynptr slice in a qdisc
> program.
>
> Cover the error path where a subprogram would otherwise lose the last
> dynptr capable of releasing a referenced resource.
>
> Also add a success control which derives a slice from a caller-owned dynp=
tr
> and creates a separate clone in the callee. Destroying that callee-local
> clone on return must not invalidate the caller dynptr's slice.
>
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
