Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11DC3E2AA1
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239615; cv=pass; b=Q+H331jyClemyIh5LYApAr1JMOPkiMYuNVJJLXS8rH07M1BYKZ+Y0wpYA6jW8n6uoQBxJKZUiwjuZmZckXdVlwecxXJYwBP9yUK0QbdIPl6HUn4RylPzl4kUE1E6nM3XOxlaNI8dm/q4HUpD0HMahJx7mFnzPUuZ4FDvw7u+920=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239615; c=relaxed/simple;
	bh=yRWSBGEUYjVICmubX7Lc43EiaizES0hO83QCFBkPwgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjaHnjyUIEcs7DLqIXTUVoSH5+79X9uYShdXrnzrkmZlMUzSby6hjvo3PnwUFZ8Gn+W/gW51nigRPI7FzQ1ntMsjdQwU6+mJqzwW7WE5VnAl1cbaC9HueIWQGqiKuuCTUghAxVK5/7HVvMcmbXG/Qysm4/MZRgTDxV9XXUoPH90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=orBCiSQR; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orBCiSQR"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b28d7c729fso1264084b6e.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 15:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791239613; cv=none;
        d=google.com; s=arc-20260327;
        b=KM2BvAN/xC6ChSu6IL/RkSri/9m7c6R2j9MtdqcEzQfacBklZxtA6lgBSMiAJFI26M
         QXqTk3gn9zQSxbWg6B0wZyGuQ4GaiWbAGgAh0mPl+6myMug9sSj3m8a+yVRZYEbfJvLp
         bRtQRbaaUwIA87s5tJ6u5Lxs5p1YoycFSGeau9HwSOOEaTSCT4I/eGPO/q1KiQH9fDmZ
         s16FWLZvxDF/Vy0q5hGUgPrCWiFCPZAQf0wC3wQpWMMMPZ3IatZU0fuTFd2seYSj2DmW
         A2t5wT1y4S5P3u9W6BJ3Xrdqto1j4HJa+gmqc2Enz+9i8RWpd2xuYtKVtFI5Qw2orjn8
         U0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WM5pNNCcUxPijH2Djlo32HfGSeTvqBnMOftUDAiQ0tk=;
        fh=Y6acA7U1LzHGK48WBdiMxAJU5QgeWpgN7vTkAilUFA0=;
        b=EtKVooAKS1UUkC76n8BMY+j8/f0hmh5xWqA/03ZYtLQp1zGZ43LSqqq8wPA2YBNrL3
         tBNG2/oxW2bLPWgorM2JwqERa1K/E1vrVa/wrbq88FSZRLQ3oD1t22yuJSh6PsXbdhIj
         SXmFCm0O0P4G8ax0eBkLEe+VqNupJ0zY8VwotSfBC1iUN+z4O116UCIQ21IJPkpUSotX
         lQ0/iouWHB4+SXyUqVZ2J856uOnTn33It7fqS7NiIZXTfhC96Qn0eOqBpnZA7yZTJIIn
         93n3nkyNxRMTNY9KtqqJZQUCj5Ek4y2ODQk9d7DpcgA4bwWSeWldktSxxx6U44YiQiL4
         GzAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791239613; x=1791844413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WM5pNNCcUxPijH2Djlo32HfGSeTvqBnMOftUDAiQ0tk=;
        b=orBCiSQRhmC9fIYGewws5LcR5O3xG7C0VpgV086xPi+QiKMU4Xz1UO76ioinPWrQ+U
         OB2SQKz2DkbkCB4qRjxMFmoApIt7jrK4QhmhPh0CA/q9TXKmznLsrLjc+uRnE+ZfEsmJ
         B2/XHTNdJ86KqdfleNFjfaymF03N0G8LyLWUZdCknozsSsgZIa+VOAgOER/YupElxA04
         A0596RNqkz7Y7poqyF9kjGx4wHkEGO3dGU2CBgORcx12yCYMSxuEUgiG41INirfT629U
         ExF/M03dFcpiBMVnL5tE0S7kfZywxuPhonrYaFBfu1PLuFfzuFDsj/k+QzX3SPJ37Tba
         kXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791239613; x=1791844413;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WM5pNNCcUxPijH2Djlo32HfGSeTvqBnMOftUDAiQ0tk=;
        b=xPJX3Dy6XJTDkG0du+jObxijUOKZ9K8H/nlHb7HGTPiJKO/PRDl+m6vSZVlxyDX/gZ
         Gwo8bMY04ZUs5wspfsFPMoGy0RNCOo8+RGzeE8RDjKiMYwZLbOplAoqptqTWb5SS6hFu
         /3GCXIazC4MX2XiTNIkD6DRQpL85v9nVo+ig8L1qUUF18o6/pWzuK1eAr6Jx6sGcElLZ
         IszGyNmrRz7XPVrijtVwxS18VIh55RpRwCTQaMnv5+Mc/6M7V0eeh/QtYgrltplTIYct
         4hmYDEA+xN38koDVA8WZBc8cAVReXT2/8P16auFRF1Z8nButNGVYR2hwf8Y5iaYqssE3
         k88Q==
X-Forwarded-Encrypted: i=1; AKwUvBzxdyFvCEKIMG4hhv8lYQgiTnKGtoHc5f0c15Rb1WE2ePEV5+UIVAjXNiWm8qcXCns60+4=@vger.kernel.org
X-Gm-Message-State: AFuF++lMG8LheJwemrjLxRlNL5gGwHemmRRCtAy8oSAJvng+BBFO7OG4
	v3hN9DJo63yPxj9pZBaA26bxIBB995hWfTf4X/f5u9uA4kfqksxKpf8x3kGg2PVOQwMMK74tB6S
	xR3rgMiLNFpnqHR6ADyF94nQmmNF5w8E=
X-Gm-Gg: AYBFou0hooFuVc9hjhhZIqlIZNOVUjR4KbNryEV0R8H11YN55qvPUx6sLkxeAPCXkPe
	PEaQ0k7aXeTynFe4ImUKS2WSf16FuObl2V3+EDG0N9LiTg1R5Cz9b1ftRlwAwQnbEj8Aj4fz96j
	82m/biwyDWxBczXS+eN7XGVhoSBgM2Vwzl9AKV+myUkE5YqzYpcXpf4bef0iX9DdxpLo2TheOnw
	zdcBr8fCkJEcCrPYY+W0KPq1J5nVTGX6VGbtr0EQUpdg/fyQYATxcn8Tdm9LCu15n9ARrhhpH+D
	beNkOBpnILH+vPDEq2foNICjndAr1e+c1xga3EyR7xZl29Pd86BgSbPEbdzNIJw=
X-Received: by 2002:a05:6808:5396:b0:4ea:5e0e:7dab with SMTP id
 5614622812f47-4f67aa18985mr7371242b6e.37.1791239612590; Mon, 05 Oct 2026
 15:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn>
 <20260927120422.1042107-2-xyx2021@mail.ustc.edu.cn> <CAMB2axPnwisOQtXymBA5jBTFNEhhummfU7xamvkMBSVC-HssJw@mail.gmail.com>
 <DLUBFR28IPJM.I3TIXG4RISTD@gmail.com> <4e4f9d51-f7f4-4bc3-95a0-27f661a08286@linux.dev>
In-Reply-To: <4e4f9d51-f7f4-4bc3-95a0-27f661a08286@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Oct 2026 15:33:19 -0700
X-Gm-Features: AclHuK_HrmF0IBK-_t-YyZ5X71k4DYITxKeHh-82u-elLFY9QT9SvK6EBIjCTFs
Message-ID: <CAMB2axN-2VWvgh4xd5p+=h9gAEY_==i_kwCTf7SF2mKpOzF9nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Destroy callee-local dynptrs on
 subprog return
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Xu Yunxiang <xyx2021@mail.ustc.edu.cn>, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 2:59=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 10/2/26 4:29 AM, Alexei Starovoitov wrote:
> > On Mon Sep 28, 2026 at 4:48 AM UTC, Amery Hung wrote:
> >> On Sun, Sep 27, 2026 at 5:04=E2=80=AFAM Xu Yunxiang <xyx2021@mail.ustc=
.edu.cn> wrote:
> >>>
> >>> A data slice is valid only while the specific dynptr that produced it
> >>> remains valid. prepare_func_exit() copies a subprogram return value i=
nto
> >>> the caller and then frees the callee state without applying the norma=
l
> >>> destruction semantics to dynptrs in the callee stack.
> >>>
> >>> A callee can therefore derive a slice from a local dynptr, return or =
spill
> >>> the slice into its caller, and then let the dynptr disappear with the
> >>> callee frame. The slice retains the id of a dynptr that is no longer =
in the
> >>> verifier state, so the verifier continues to accept accesses through =
it.
> >>>
> >>> Before the object relationship refactor, bpf_dynptr_data() slices fro=
m
> >>> referenced dynptrs also carried the shared reference id, allowing a l=
ater
> >>> release to catch some of these escaped slices. The refactor made thos=
e
> >>> slices precise children of their source dynptr and exposed the missin=
g
> >>> teardown as an accepted stale access even after the shared resource i=
s
> >>> released.
> >>>
> >>> Add destroy_dynptrs_in_stack_slots() to apply the existing dynptr tea=
rdown
> >>> to an inclusive range of stack slots. Reuse it for dynptr initializat=
ion,
> >>> variable-offset stack writes, and the entire callee stack before free=
ing
> >>> the frame. The teardown rejects losing the last dynptr for a referenc=
ed
> >>> resource and invalidates the dynptr and all its descendants, includin=
g
> >>> slices held in the caller. Propagate errors through prepare_func_exit=
().
> >>>
> >>> Reuse the existing teardown API and diagnostic. Update the affected
> >>> callback test expectation in this change so the commit remains test-c=
lean.
> >>>
> >>> Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and =
fix dynptr UAF bug")
> >>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >>> Closes: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.ke=
rnel.org
> >>> Suggested-by: Amery Hung <ameryhung@gmail.com>
> >>> Link: https://lore.kernel.org/r/CAMB2axOmdHwSrHihSRskDywkCmEGQOX+6dZP=
N_A9u-HhxY3UDA@mail.gmail.com
> >>> Link: https://lore.kernel.org/r/CAMB2axMmrTb+UZ84UD48MwMtXbk1s9bWtreU=
3AOfjzU0fPT0BA@mail.gmail.com
> >>> Assisted-by: LLM
> >>> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
> >>
> >> Reviewed-by: Amery Hung <ameryhung@gmail.com>
> >>
> >> Just a note: this series addresses a related but distinct problem from
> >> Ihor=E2=80=99s work [0]. This series handles descendants escaping from
> >> callee-local stack dynptrs, while Ihor=E2=80=99s handles helper-owned =
callback
> >> arguments whose lifetime ends when the callback returns.
> >>
> >> [...]
> >>
> >>> @@ -11675,6 +11683,12 @@ static int prepare_func_exit(struct bpf_veri=
fier_env *env, int *insn_idx)
> >>>                 }
> >>>         }
> >>>
> >>> +       /* Invalidate callee-local dynptrs and their slices before th=
e frame goes away. */
> >>> +       err =3D destroy_dynptrs_in_stack_slots(env, callee, 0,
> >>> +                                            callee->allocated_stack =
/ BPF_REG_SIZE - 1);
> >>> +       if (err)
> >>> +               return err;
> >>> +
> >>
> >> Conceptually, Ihor=E2=80=99s frame-reference mechanism could subsume t=
his
> >> cleanup if every local dynptr had a separate frame-ownership
> >> relationship. The current parent_id cannot express that directly
> >> because dynptrs already use it for object and shared-resource
> >> ancestry.
> >> Supporting both would require another ownership edge or field, rather
> >> than simply assigning parent_id to the REF_TYPE_FRAME id.
> >>
> >> [0] https://lore.kernel.org/r/20260922010333.1226537-1-ihor.solodrai@l=
inux.dev
> >
> >
> > I feel it's ok to apply as-is or should we defer until Ihor's fix?
>
> Let's apply this fix as is.

Second this.

>
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> It can probably be backported, and there are no conflicts with what
> I'm doing.
>
> The REF_TYPE_FRAME change is a more long-term thing, not easily
> backportable. And it's not ready to land yet, so no reason to wait.
>
> Thanks.
>
> >
> > pw-bot: cr
>
