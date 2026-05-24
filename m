Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48F2D5940
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779621766; cv=pass; b=SSvkrh9uZbjj5Bs/aRcepSYb8UE4LWuNN5P3iezdoaGDINUcif98jfCF2MrpCzJSQahOi7/BEOP2Lu+yZdl2WnvqmkE7bDcAaoQVoqBqosctiTrixcj4SbXkxn7JK0sB1f2NtJvQwy8n7OWmChVEXt5PeOeEfMmI77p8vQBYAns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779621766; c=relaxed/simple;
	bh=O+JZPaK3uRnpTVdRdyFVDzHP/W2oZHJawf02YCzFly4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgMMWC3HhQ2b/5n32EN+8eJg/yqJMIrMi/PNVnxoMdATm1MgmA+Dy8SfdTLZOCxv4u+AUi6d7EbnInyhCxqp+FOrr/cLtlTMlkA/fHY6Wzb20ZBcpBofakxq+z6W4Ptdf1r8tcykNBYpfdFgky7aRGOAb7Fnw+mq/IomspV/u2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyW8SkrH; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyW8SkrH"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so5168927f8f.0
        for <bpf@vger.kernel.org>; Sun, 24 May 2026 04:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779621758; cv=none;
        d=google.com; s=arc-20240605;
        b=N6ZLMaQtCg3LDG+3Oqn2cz9qUoXnoTxbugLeaL66dhDvpuKgfVpLYVBEHizBRIoJw/
         3u6aMmoDyRuaA03rpNPaLMcrOSHVVbtSE4CWj9WCpq7DvN0NEI/2bfVo6RJe+R51tj2g
         McatpgEqGi0FoGpGu3sRbQQ1LT35/gmlS2H5e98SQ8nIHy0AbVjggkXDyJ1XX/ptWjLx
         SIYXjd1uPvemHp+gqTUsLaYNzejoxmGojwY7o2hO4Uac9Akh8T0cK86G9rYjd6FzODC8
         uU/Tcck+HOJUleHAG4iv5Kyr7NU1ec1cZzuk8V0Q6OnJAzisU6RpxRrnLCegTDPuF4Wp
         KCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JYSKa/1O4kDWFIkCrrL8W7AexNe9Onv81BeAx+bBfI8=;
        fh=NQA+fdPCvGbFYqivaPDcFENgLUgAsnhGW9Kv6sBnL9U=;
        b=i10GVWZOwq1tAR3MMvn0FnmGlKksjhD+bXapsTKl4RwiONfa978yCfl1XArroKlAbt
         iwfAYMpJFWV14sp61pLD0EZsHs72FXbSHqPMbdNTw+4h0E2RygK7q0DXwmsUT6urkF46
         kw9Yi45UwfXOtQ/jkdmmKt8dTyzQivksCIr/jW1zjoDFLGZSXLlF7cV2OeNLalX0DYfT
         dkt6ItP8yPhN/JAxBoqwbgrElbEeHS0Nkyv4F9CScFMyxNVzdvNbYZuvlgvDw2GADV2p
         XGA9JMZzbdl5Bfa91sN/L6LHCWLKNr3E9A1FlpeIo85Wb9m3NZh8MPetkm0z7+IjRm/B
         u+IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779621758; x=1780226558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYSKa/1O4kDWFIkCrrL8W7AexNe9Onv81BeAx+bBfI8=;
        b=fyW8SkrHpdAp0E10iPgLN4TZJpk2OlISyv5ozXCIVPOd7D2/eDJDYOH2p2jYkuoptK
         tzuaRtnwbECR2zjnISJcnL6m70BdPShM8C44Plua/pKRwW5E4j5RehDSkgIY6iEohDNw
         yHofDReNq1PN2D5LKlFEvPRUXYNWqJaQRqqnA/CbCo3gtfX22ZiCRM6J64G6jBkuq1Uz
         6IG8sczDjWpQ7MMJe6rDWMfmWumb7dFedFWztRBBc6hnbXrA9aiqhLcFmecXbm04GPAr
         V1wguZkwSSLZm8TaY886ZJ3n8UBqg3aOsfTmB2pSlsbnyzi03ArfyVp1cU9VaRTsXV3u
         6YPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779621758; x=1780226558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYSKa/1O4kDWFIkCrrL8W7AexNe9Onv81BeAx+bBfI8=;
        b=N6Gi3SdoZUvllMbukzQUOD8KHH3EQW17xf8A1b0TntoyTtNSP5VBcPf2wMVu2DkgO6
         zCsvdbSpMHuBFqoR/6RPwGj5H9kAP1TV+WszOO2Km92bhRfn3wU2xaUBfcbbcWgzMeFF
         djhdNmAOuQAtwabeBUgzFfes/FR3PMqLYHNB9yvGbx2yXG942TP20PnkhteCE0vMWiHa
         Z2sEl9jSkrSExNA9AnzwUVCLTgGs1RfbvsYze5VJ7ztne5EmI9H4o2hnHmCPW6I8ky3V
         1xXaF5/FKTHpJGRiz9AnEWmc2gercxug5yDUoGXjgU5PPfbYmorcPD1ofmvpuzP3vs4h
         erPg==
X-Forwarded-Encrypted: i=1; AFNElJ8NDYoiJLZ7jlKed64YIExHtFh0jtwUbkZ/PYmg8eT5lT2jJ8up57SUr0PfNUwSrdTUkz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweffFlL2z3L/7r+EyznYwU1QAyGR+G4rIGSCUN6qs0LZAbzy5i
	3eWwNX0wNosi/r7DytoBHLnTHXqplZdWARrq+VZaE3GVfpxZ+/RWN9j3bCvfIt8XZDFqRDlA6oT
	CcKhGEbgCNXbNUDVyUB4HyNa9lhKK/qU=
X-Gm-Gg: Acq92OEsRE4ZAzeD6HqMMLpzuIq0FmtjPnMBSbEOoRRbMdeCfK8tUHapem5rFb7OqFI
	WHm92JpzVkbTTtu8zvCZhmufks/FUzp8iX/kULnOWWeiE/ou1WkKuKqaR6+rmqoiOxOom5M1rBD
	SXC+8sTAP3lSqyguN3J6Ki9snv3wMt+8xV+opV9mpvvIygg3KxGdovKISv+114kZhYnXtxLxiBq
	El8AXnJi2V+jc1RGrAkptYyQ/7oFg8DRYHSB2iwI+RmwShYaC1DKlV0NAhQH+If5P7sGO3ulEmJ
	aoJ9gW8y6bJGDReRVV8rUYNBsHhmwk6rgYpwIuJCp8ZPpIUt2XHoGCqcSnidGDAbZegL/w==
X-Received: by 2002:a05:6000:468c:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-45eb38b392bmr12088047f8f.20.1779621757808; Sun, 24 May 2026
 04:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
In-Reply-To: <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 May 2026 13:22:26 +0200
X-Gm-Features: AVHnY4I78oJkw5wlqyzmj1cIkIp7UAJvj1KW0IsPVe2CbVCPVcMgnKOQ0enezFI
Message-ID: <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Yuyang Huang <yuyanghuang@google.com>, Daniel Borkmann <daniel@iogearbox.net>
Cc: bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 1:41=E2=80=AFPM Yuyang Huang <yuyanghuang@google.co=
m> wrote:
>
> >This looks like a bug fix for an out-of-bounds write vulnerability.
> >Should this include a Fixes: tag to identify which commit introduced the
> >unconditional copy_to_user() calls for query.revision without checking
> >the user-provided buffer size?
>
>  > Fixes: 3fe213c040b3 ("adding ci files")
>
> I completely missed this checkpatch comment. I will add the Fixes tag
> in v2 if there is a consensus that this patch is the right approach to
> resolve the issue.

AI is wrong.
The fixes tag should probably point to 053c8e1f235dc or a subsequent patch?

bpf_mprog_query() and tcx_prog_query() were only introduced there.
How come your userspace passes shorter uatter to query newer
BPF_TCX_EGRESS attachment?

Please provide more details.

I'm still not convinced that what you're saying:
"
For example, our Android net_test  suite uses this legacy 40-byte
Python ctypes struct layout:

  # legacy 40-byte layout (pre-revision field)
  BpfAttrProgQuery =3D cstruct.Struct(
    "bpf_attr_prog_query", "=3DIIIIQI4xQ",
    "target_fd attach_type query_flags attach_flags prog_ids_ptr
prog_cnt prog_attach_flags"
  )
  # Invoked via: syscall(__NR_bpf, BPF_PROG_QUERY, &attr, 40)
"
is a kernel bug.

Looks like user space is querying new attachment types
with old structure.
Potentially the check can only be around:
        case BPF_TCX_INGRESS:
        case BPF_TCX_EGRESS:
                return tcx_prog_query(attr, uattr);

to be nice to broken user space,
but, really, attr->query.attach_type shouldn't be equal to BPF_TCX_EGRESS
with a smaller uattr.

pw-bot: cr
