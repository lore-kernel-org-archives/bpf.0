Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A317736
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775360016; cv=pass; b=Qy4HvFJW1eP9fIGJjhenMFvYVf7Ey7Z6cdUQsb7IYMOtsPyQnt+enWrez3T10VI7q0I41jCvMr5UQ5ILyrAz/JrlPx0gG3Rz89pffK7+e23H4ei2evkLwKI3xMNc9XOS+rJXepwn0cOLuMfRYICFQKQQ8198WhVAi4JTKEo35oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775360016; c=relaxed/simple;
	bh=vfuj1me/nw7fcj9Jc8UbRw9nNQO3Z40gUTJxieRgTKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dm4FiealiilLLwE2ihktx6I522K2e3D4GGvw2HTAyvHfKd6XnLRkfLur9IhwJRVI6V07sXj3SdghOrhS3UC3bbYsQwP0dkx744zv5ZyqVq8OjhOMsHJUv00y1i2Jo+37ZRO+hze9TQkTEC7KtaAuIbV6Dbnh5dMrMS1b2LB6TPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go8OdJF0; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go8OdJF0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so26655915e9.0
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 20:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775360013; cv=none;
        d=google.com; s=arc-20240605;
        b=A7/m0JxTZNart13m3I1I07ae1HzUWLiOSFMpDqqT0ra8IalmvGuHZJYEOnKcfpGOrd
         fEMuMX8iziTPJ7i6tMqbu3O+3hELH3wg/vkK1KhVDZCoK/XbGQGGR5IM19ek6ySL41lO
         icq6mRLxQeg8RWX6FAZQAB4kuO8vhkKhglqkjtSKLHFQW4DBu/MRE7IVNYRawVX7GkPU
         kb77bFRRl+AyUzTY7esHM0+qU+kCG45in8JV01PfsXnEdnDsHCU8XWb7KfjKbtb4Imqb
         FQd5sjA6YJzei9L5jPXzP7qDpA/MdtGDi+DpYbSlmhAZjCbVSOimomt+gOmewCfPWDVg
         MngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Hgqgf1Hk6PqZcfl856JggffqwCP/Ql70tsWgSl1PAU=;
        fh=z+FAd+xZOmF57zxNNieIFDPVu/tkmh0wVB0LomYnje8=;
        b=BeZ5MMnJA+fVbTN3C81zzZsvoAQGFLAo9vK7NDUKr6NknCzBm2L1eQmz5wlJQrp/n8
         8bsRwG8ChH9Ne1yP1oXYF8FTGrqJqIqguxwXcldOYxHx8Qb4T7h/m8hXGMpTIGxVLTX5
         QEYIjcl6onAwAAaErFAbhdQcV12VPbHqkg5FxRLWIW2e29EOobaiqwheeI2alPDp6kGQ
         CLkhAGAqs+yr8pPg94R+hlWeFq+MlOuhHOA+FhO0QCQtT6GOX7Ebtvs2iM1qqZ386c9O
         6r27JG8kWdQFabWSgPgdsBPK13gcqudzZ55YwIkFiEruEghcnbM+2nIfGvdvlvBm70KC
         U7nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775360013; x=1775964813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hgqgf1Hk6PqZcfl856JggffqwCP/Ql70tsWgSl1PAU=;
        b=Go8OdJF0WO2481uisxcZsm/53cIrFMuhud2Gliqw5wLV3QMYB6G/K6A2BmkcIftwh3
         p/sZqAKPChsMMDWal+mXJ3CCrULF+R/HVXOcoR6SDSvu8sHVIM6ptlouEJbLFC/eeHlQ
         kcVKZwGdOMrn1euzwAMukaAtqzMlZWmqiIL6cPkrAg3UG7TUDAv6NkSomZU6I+hy1vdk
         sHR1ppY82tUL/cRlttVT1BgKIwiXPCRiCN8LjclLxWTZZ7YIAy2qPFpmD2XivwzSfNIE
         62zTx/ma+4xysgXtHgkAR3mb0jB2kv/0YRjkES8f0VjgLR5NVbdo1Tptz9UCfufpXpvX
         WIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775360013; x=1775964813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Hgqgf1Hk6PqZcfl856JggffqwCP/Ql70tsWgSl1PAU=;
        b=GWYGDLuqwEJukYw3Asr7Kzd1ok341qi5WwoZ5E5Do5rDAJyGeoFfTCDxx2Mr3A/ul8
         y/A1KSyqwBp8CqFV2dmf4uDdexgurT5tfrGEfoliwPTotGTLTA9+veNaK03+yMBHVcka
         1U/G+gP027LfeBC7okOjwW+WOQXZJoIQ4PEu3sLjlX0iRe6BunP8MNx3XpQZ81rqUbmG
         3mW5ML97/KFNLj57I7BO80lGW9F6xHnEj/SwarR3/lYTNw7aMG/padXLv1Lzeoe3RKnt
         8+VikeQXXBPX12mFPvUzLGrW3VmYl9oe10SQU5jelhZftJ9gLH9Rl5S1oHPJFnbFU/mK
         cWLA==
X-Gm-Message-State: AOJu0YwXaCO65SQdF7sN0WUKjcdXc3DTaXqFcfvgMaM3fwmd4d1EMyzO
	uQr9jetVzDww18RgiYHgakO9zkLUoq23Bz9aVI5B8M69id+XnOvWV9ejJ1wCEr5zkZpXYgMpG6d
	AYLLHpXNbUGGp5Vz53zWCPiBsxDgWJWA=
X-Gm-Gg: AeBDieuZDc9O8Cfv4aMacGwDNj/wBE22/81c6vIC3FJKOXNjH+SvyQ7xfdoCAVAhEet
	V7esnjje/g/3ThzTti4vABF3CDlIKVdEf5Ippm5FcbGLFDvJ2z3Uy0xHp7U8FV5QIDDDisy+dDv
	Vnbr53HxPvQnTYFjbuFuUS6P0bJCPNqwPoRm6hFAIjV+9LR6FW8Hfad8JnM1yDgoy8uCNsZ+8RN
	pADEXqOWux4B1e1ZP5OdOVDI/O/vPrBU39jfz5FoQsI10JWEwuy4HEv1Cul8yDi/NiLs3w809lJ
	ttVyCAkJGRzX67SZhLFOrCJNq6FMSdkUlA2xs8SMcTAMTSu0k25d6voZNsr9O7TbHIHVR+j/UeN
	T0HkmJUkH4KpbGykKvIhZaVmsKQ==
X-Received: by 2002:a05:600c:c10c:b0:488:9701:b0a2 with SMTP id
 5b1f17b1804b1-488997da973mr82817255e9.30.1775360012687; Sat, 04 Apr 2026
 20:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403164040.73269-1-vineet.gupta@linux.dev> <20260403164040.73269-3-vineet.gupta@linux.dev>
In-Reply-To: <20260403164040.73269-3-vineet.gupta@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 4 Apr 2026 20:33:21 -0700
X-Gm-Features: AQROBzCP8fMjzTReT7FK2fX9f251KKeDmciOmPPlZnwpes6mdE8NquAqwoRtymA
Message-ID: <CAADnVQKOzLwz+V7CNgOYRZ+UykMrR-=OGMg0DjX_NM6B8dSr1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] bpf, doc: Improve MOV/MOVSX documentation and add examples
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, bpf@gcc.gnu.org, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 9:41=E2=80=AFAM Vineet Gupta <vineet.gupta@linux.dev=
> wrote:
>
>  - Add missing form {MOV, K, ALU}.
>
>  - Add some assembly (pseudo-C) snippets.
>
>  - Rearrange: MOV content comes before MOVSX.
>
>  - MOVSX content itself rearranged: canonical sign extension variant
>    for {8,16,32}-> 64 moved ahead of the special variant which only
>    sign extends to 32 and zeroes out the upper bits.
>
>  - Remove the hyphen '-' in "sign-extension" to make grep hit all
>    instances with one pattern.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---
> Changes since v2:
>  - Fixed RST markup for asm example "w5 =3D w9"
>  - Added asm example "w5 =3D (s8)w9" for {MOVSX, X, ALU}
> ---
>  .../bpf/standardization/instruction-set.rst   | 49 +++++++++++++++----
>  1 file changed, 39 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 96181565906f..863a0cc22a75 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -414,25 +414,54 @@ etc. This specification requires that signed modulo=
 MUST use truncated division
>
>     a % n =3D a - n * trunc(a / n)
>
> -The ``MOVSX`` instruction does a move operation with sign extension.
> -``{MOVSX, X, ALU}`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit o=
perands into
> -32-bit operands, and zeroes the remaining upper 32 bits.
> -``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, a=
nd 32-bit
> -operands into 64-bit operands.  Unlike other arithmetic instructions,
> -``MOVSX`` is only defined for register source operands (``X``).
> +For move operations, the ``MOV`` instruction has a few different forms.
> +
> +``{MOV, X, ALU64}`` means::
> +
> +  dst =3D src
> +
> +e.g. ``r1 =3D r2``
>
>  ``{MOV, K, ALU64}`` means::
>
>    dst =3D (s64)imm
>
> -``{MOV, X, ALU}`` means::
> +e.g. ``r1 =3D -4``
> +     ``r5 =3D 9282009``
> +
> +``{MOV, K, ALU}`` means::
> +
> +  dst =3D (u32)imm
> +
> +e.g. ``w1 =3D -4``
> +     ``w5 =3D 7302004``
> +
> +``{MOV, X, ALU}`` has zero extension semantics (upper 32 bits are zeroed=
)::
>
>    dst =3D (u32)src
>
> +e.g. ``w5 =3D w9``
> +
> +The ``MOVSX`` instruction does a move operation with sign extension and =
has
> +a couple of forms.
> +
> +``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, a=
nd 32-bit
> +operands into 64-bit operands.
> +
> +e.g. ``r1 =3D (s8)r2``
> +
> +The ``{MOVSX, X, ALU}`` form has slightly different semantics: it
> +:term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into
> +32-bit operands, and zeroes the remaining upper 32 bits (similar to ``MO=
V``).

This reads too conversational. This is a spec. It's supposed to be dry.
Overall I'm not sure it's an improvement.
Only (MOV, K, ALU) worth adding.
Please cc David Vernet in the future patches and bpf @ ietf.

I feel that both patches are wiki or faq material than IETF spec.

pw-bot: cr
