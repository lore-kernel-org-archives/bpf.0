Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137BC19DF62
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723644; cv=pass; b=NpHvENowrld90u2sPQ2ktwCKEO1BgApAhc7vhPRLClTPAeu9nRky5TjAc0qYqZoWNUjz+VkJ8pJrm9QD5z4zl/vdiWz7hs+7eUc4aIt/9S2Wh5FNLymmEiHyWEzi6QBW6p0rPBKw02H7m4N3ro707waw4tb55LoI8WVoMXiNnvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723644; c=relaxed/simple;
	bh=nHOdUJiFOBdWfwScJY9o0u/7iDJXeJBSazB/azPRC0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5DB3bwfXLDtUK0cjATAOAhtr2B87R4pQVFG9MRiVASZkxvdfPwYg9ap3QNuu1fndPHTlQXtP36eS4kuGAGVpncRV+SqaTCijUK8m+qNnTV3e4zVNdH/RMWXyG5YZHD+A6RYEuKjHxo5USVcAOBujo+dbG+Q2I0985G4hCviwMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWZ3GLQA; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWZ3GLQA"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92f03daaa97so157868685a.2
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 19:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785723642; cv=none;
        d=google.com; s=arc-20260327;
        b=MFJ2Q4ehbLAQDlrpTCOIp3nQRmrjz0godrC8uCBlh+GYevn/voHQZ9Z/se6oktD4R8
         JffNswA12MjoDtjXpvpaKm6qml1kve0lVsLkfPseoeFWynbhd5L9tW+72LCGP+qAXyyp
         MUWWpJFksVC+P1bGkcvczVuu4FJIDyDKJdno0M7Swv/UGze93Cgq/lt9Lnx7diT3OgQM
         Tz4+32CsZC5RVlprqjSIr0Fm2DEE/yRd1obWlCCpMOaI2uXePK+Ns1IKVEcGZTLnlDfC
         1hxtoPHKeDLxHZzCUGC04afnV+sF+mYWGRU8Hsjrc7SLSe4+KbhikCrBljf++6LsQU2k
         Um8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I8x/5zsaEEccMOJBOWfmd8QIoQoaOAGrwb7utr6PXbU=;
        fh=aPsC+eNXzNnD2UcNUare9DxS3XhsQTPLsqBLfiP32lY=;
        b=XjRJ7SuzCkKxjEX0gdnO92Cw+RwwnyCYSnflfFKb89CjqTxPdSs7qix2gJDbbEgAZ9
         sNLaMEh6kluhXo2zWmFREYOiRye+cL+bDO0IXjSO5uINIWgtVJaKdI+2QMcHBMCK7new
         Jb3O+kTkq0p26RWVH0MjeaKz3fXVpFE+MdUrkTKvjuhChyVG44t64C6+uHr85NnMbOXG
         dVqtDvpER3JGidIMMTUdZX7R71jOqtiaYHGf79I16DHN5PK6S6Q11ekshg0C5/7GaHbK
         B34iTIZI66UKuwt/2XNPRvepFlVEVgoMEYECzm7kz63RK08KwB60OBBMRkSpJn/Tp0A7
         bgbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785723642; x=1786328442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I8x/5zsaEEccMOJBOWfmd8QIoQoaOAGrwb7utr6PXbU=;
        b=NWZ3GLQAGqQSzgwOPT4lFaw4cOve7T5RD0heRas2pZpdKIF/Lp2+KC9Mw3t1HeiTFd
         GrOUtxgJcVvz3rSGmNt0Fh4Qkg53AFskH1z579ju8uYQUasR8njLzFLTGoJab8s4XmBj
         tqRvaM94XbeYzngAplYkvXrefspFSs3Jt4jK9Wrc1Hucd/Nks5hwY9NKT607PWpvIOmZ
         c7N9UwsgVLeNf51ToYRNT/H0MYWanTThWn6XYITOCRUGvy+8tP2Wc+eOdZZXYvPVJzbl
         YGh9PAZ0ef119cGCtDk7cjbB6e4sn25FyEG7HvNHMnDx5Fiv7a41V2yWl02UKJ8f7TGo
         nasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785723642; x=1786328442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8x/5zsaEEccMOJBOWfmd8QIoQoaOAGrwb7utr6PXbU=;
        b=r2Vzf3kPzsk/jTg4yCQM3v0D3cR9WaGGfYwURTxuOyPOiNIGiao+Q4EAJG+GwHLpvA
         qeQ2zKriu48paoL6PZM7ToymhWsQXRAfwB3ztVYhMPou0772r+kiRPrjTMsl8T99XkLD
         XTIx+RaTB378zHNbxUIYMvJb/xxOEevFOZt+ri71LnViuQmFdYZn081a8bAm9/wMvA02
         ZuX3250XqhcZ5e6ymREpfm4Fa75yf6qnD4b0fDtlmCl3bjKJWl9B3b692vgNuhXIQrxs
         gLwRp3kFR66WekuUybbTZqESHOSJRGG7Mk1I6CBIvwuTPfhDFJ2yWxIVupZViCECifpu
         YRww==
X-Gm-Message-State: AOJu0YzaMDb8nXuw0Nc/0fv+UaMV2YfvrhY9D7OVq78fj46HfruDezEW
	KITB4tMvb3GSlGzLU4UuVSWilxyFEy8z5qnmuu2m7vZ8//2/BVJo3kSPz8g1N1LN7+C5OsjzFir
	UbZADBE46RTzftKc/kcUczY+3IAr8O38ItXkw
X-Gm-Gg: AR+sD10wtzZEVgOLWIFv9K5l/lxg+02tNFY/poOCqwBJRT7j2zOM+tsEmDMPXxucrDl
	kotePGBrB0qIXNUfpA2DSkjNyNwksV3nokk93qFBibyIq/WkIP34azBm1Mhrysr3rGs2SLXHI2c
	A0jsV82RBA+NtdnU2oKOgqMmJKmjW9qtGl2uBSs94svxpxuryAu1Xe+KOLWkPWMEAnoPtVOfAIf
	CANOMm/TshtBUduVHBOXsQJVQ0bXlQaFhAQ7Xwya9QZ90ll5wJUxSJvOP0D9Dwmp8CkIy3D6hOV
	uNjW8GUsfV8yhwdGVCbV7lKRxir6N8s0/hywvXbMmZa2pW+GwalaFm452OtAKlnDaRIGdP7Ttuc
	=
X-Received: by 2002:a05:620a:6e19:b0:92e:b1ca:8ea3 with SMTP id
 af79cd13be357-934a0afee70mr1278443185a.47.1785723641894; Sun, 02 Aug 2026
 19:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803021643.2189641-1-dwindsor@gmail.com>
In-Reply-To: <20260803021643.2189641-1-dwindsor@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 2 Aug 2026 22:20:28 -0400
X-Gm-Features: AUfX_mysI4MMhh5J0Ey1f-wf9yEiswfDecbNV8kHCQXUVpaN2rD_qs5ei3LWkQU
Message-ID: <CAEXv5_iXbExVvOSyOu_BsNeAjhqBOf3880vfUDbfLNmKPgLVXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add BPF_F_SEALED flag to seal BPF links at creation
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 10:16=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> Introduce a new BPF_F_SEALED flag for BPF_LINK_CREATE that creates the
> link permanently sealed. A sealed link can never have its program
> replaced via BPF_LINK_UPDATE, can never be detached via BPF_LINK_DETACH,
> and holds an extra self-reference that is never released, so the link and
> its program attachment persist until the machine reboots, even after user
> space closes every fd referring to it. There is no way to unseal a link.
>
> The sealed state is tracked by a new bool field on struct bpf_link.
>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  include/linux/bpf.h            |  2 ++
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           | 41 +++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h |  1 +
>  4 files changed, 42 insertions(+), 3 deletions(-)
>

There is deliberately no selftest for this, as running any such
selftest would necessarily create a sealed link, which cannot be
cleaned up.
