Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCEA376BDE
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029900; cv=pass; b=j6s+FBLuk4WcvMk5vAIZ9crJesYZFNYt5NFfkhaIvbrBPuDCDTaYw6raJ8x6g/FQ8kY1/4pcDMtWpCyWRi5gJ7aI4M6S7YsUpp44wT0EhOBL3URkHIFiuC/YCm9mWgrUiJB1fY2U5EL1qlTWKZc7JdMwcmflv4ztq1AdKmAuiSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029900; c=relaxed/simple;
	bh=eQP2e/SSLB4Pxhr6C2kldz7+bmcpYvVX3g6PAxO4izA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE0d/qx9ONOKAnAqIrGssrY62QymWApMLrF770oHkMp0/sYRRCavWcH5ZFXOGa+QwOGusJbdLD63iRC1x0jzj/nxLcmlfCu1tuA6o58ILyHxcxMeGGNvazuhbHPWxx2wfm7Rtgrim21QdR0G48Se7kvHVPGhnKzXeVLJQZ+UiXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOKyv5qB; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOKyv5qB"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e61648f10so4851cf.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 21:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780029897; cv=none;
        d=google.com; s=arc-20240605;
        b=KarvIMcnUHmsPxYUfN2JsTpv72lH8DTYG026sT2rNmJnKzqgsHEsZmuwehwCoStbo2
         R7NRoQw2goZbgBnNyICmZ69WsXu/sgDnUk9I5XoRGarDiO7OMIoI6ydChu4mCpu7zfnn
         dJjscMcHS5MY37LOLbFmE6euJRjINXYglN7YVtR/QhEbOLEKeFdDbqlCzJ6enGPgf+zC
         JxaWN5FzwvcoLK/kZG1OBfBic/epgXPj22YQub6gG7ldcpOiPZL322kl/gc9emACOU5x
         wSSjJkucDMzj0fPVaethwPddu7VxxD7FLv3Fvsn7rQLROWeaHIt0UEmYuuM6e+dw6zpG
         Xj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CeB6crplwXIBRzpCdZlH9G0V46TK/YkUIeRLLxmd+lU=;
        fh=CFTCol1n70tFKVcKzv+k+CzZUHZcRPdxAiBkxYOfsF0=;
        b=YdQijlxjD6MaS/ijIztQjbghRTJrmvXK2rUDViF0vrIiR6GYQeA29MdBr8w9KviQop
         c2/Xdmz7w3OWXiuJEq+slfeKjs6ZmoQBbCtrgo4YeUsVZcpoRGx9EebgMqlI1qFLreuc
         dTt6T2N+HaxwQj68Pj/62u/D0uwZMbRTXpvdwwkVehg4j640DuNVtoQKoSzobLw97Tm+
         DgVlcfObLz/RVU60fh352zW9y+mqh9nxhptQq88MVnVRbNguCV926RTpKWfLwICsPSnd
         gDl2zkwwLaXPnDbOpyoRt15uGRMDHRXCYF4zh7U56fvWzSnH9i6Ne+DkCZyRIRhydJb7
         0Jpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780029897; x=1780634697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeB6crplwXIBRzpCdZlH9G0V46TK/YkUIeRLLxmd+lU=;
        b=MOKyv5qBfjv4HCt2SmfipjFFImdM5broZf7t7YOzLBMto7GTY2z7+QlCpn2lQzfew2
         9mB4Pi+9ykpUcfihDza+3pofT8hJkfI5SrmRpIbHTg8T36OHOJF/zdyo7hLBs+jIH3pt
         ncZVuyMWag8zlPlxNErYIswBIxLHSxZIpBwEGl5foGHCxy5yUO35JvZ5S6F96GMMU7SV
         oc0JbdLn7YTV9hbsoJ5iRWTpYuuz0bZDLGnO7vXDx9ERuWi8WMjACjZlXeJoFwY3wIql
         sy03TLTDAgxPtfquR2OJKb+N7lN0itUY/epr8dJ8i0X65iESQchoS33+x86MyGsT7p5Q
         FVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780029897; x=1780634697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CeB6crplwXIBRzpCdZlH9G0V46TK/YkUIeRLLxmd+lU=;
        b=L3+PBjEj7KInY8jx4MMKSDs9oCGUbOPvWtpeuBraDmlTJWFbmEZ91YDypF+Gs0+1Vr
         Ucd2waexwYZIIZX1kdZMGLB2ZANbcUH7Sjv42aneKaFaxqCv7kdrAm4ynMH1EbdQXq4K
         MdLGluiZvh2V3H9HONgxgKEbj1qXTgl88CklYgSUwkXzaqUOd/S4DmLZgMY0maLahUHW
         PJghyIGBDBKEmUpd5WT/gHIGGPptIWYbcSpqwJbHPsVfJaohxiQ5Atw8V0yu9hut/5HT
         YB/dZrPpIjiN1R/EmJgYJv5NASppIsZc1YoS67UBbAzhxTAxHeJfyzCNk9/9leX/uNaw
         R2uA==
X-Forwarded-Encrypted: i=1; AFNElJ8GwMjZXzv6HFKn4CH5DbI3AJFlHSSHmBVdpxrBwUNHQvnV4KdCjvzcOvsMTi4UbfEmoKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/dj5o0ADPqSkxewcZE1Sf2xzfBYGJ8VdZnmgAe/tYI5XjgS0
	nK+Cld/jEz+1+z3mzCN4x35iilxOvYXCbedmM0w46uggBw1twU85o0/vTLAOX1bF6+JlsgavSyb
	6iZjB53s73l+KNMelSEjfjchLPS8KRafnpJvGxz4a
X-Gm-Gg: Acq92OF2MxG4NLLP5tM0TI17obp1HJG+yZz2QZxETw47CLM+8gj+qIZwVRk4fuZ+XBS
	kcUPRO4RmT7YGYATyALFRW3SyybN8XQUG3xOnn+Y8u69TW9s3hk0QYppeNgQDd8t0XjSh7epyYG
	zi9RkQKqEPvjzycMNiUA0od7fJbIkeWGaUavvos2ncwT3JJbxO8U8bR8nhemb5u+I9c69ylMD8t
	ViiJVgTAgylG8JKcS5d+MTDD4YHV1gYZ/xKFp0AJ6ZTYqyi/upWAm8lPfo93V8q2x2W72iWH8TM
	D72CvHI+vst2tmIP+adMVc/ecgA+xAcsjMHZG/eCcLEObBkvQ1z6zELnBtFjDPfx
X-Received: by 2002:a05:622a:9d3:20b0:50f:d03e:6482 with SMTP id
 d75a77b69052e-5172dcef32amr4403711cf.4.1780029896687; Thu, 28 May 2026
 21:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
 <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com> <DIUR88219HWQ.26T4D7ZX8CNTC@gmail.com>
In-Reply-To: <DIUR88219HWQ.26T4D7ZX8CNTC@gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 29 May 2026 12:44:18 +0800
X-Gm-Features: AVHnY4KeGTzWQs0Ti0amBOZL7bylrTP3wH1i0px8sXV1Q7lFoUnTtYhLJT-e-9E
Message-ID: <CADXeF1E-QpKj-37T5ghiycXrVR_YN72fOc3M4OQg-Arz7JNjsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bot+bpf-ci@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
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
	Ihor Solodrai <ihor.solodrai@linux.dev>, Todd Kjos <tkjos@google.com>, 
	Carlos Llamas <cmllamas@google.com>, Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 9:03=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon May 25, 2026 at 12:21 AM PDT, Yuyang Huang wrote:

Thanks for the reply.

> Ok. This is fair. 120933984460 is indeed problematic.

I'm glad to hear we agree that 120933984460 is problematic.

> Not really. Your patch adds checks to what looks like "random" copy_to_us=
er()
> places. This thread is clear indication that it's not a "robust architect=
ural path".
>
> True robust path would be to wrap every copy_to_user() into another helpe=
r
> that takes uattr start pointer and size, does extra check, and
> returns something like ENOSPC (and not EFAULT),
> but that would be a significant churn.

I agree that the truly robust path would be a proper copy_to_user()
wrapper instead of doing the ad-hoc check in the current path, but
indeed, that will be a big change.

> So I prefer a minimal patch that add single check in bpf_prog_query()
> that checks that user space supplied buffer is large enough for attr->que=
ry.
> If not -> EFAULT. That would be better than overwritting.
> One can argue that partial copy_to_user() in __cgroup_bpf_query()
> should still be allowed, but I'm against partial and
> inconsistent queries.
> query.revision might seem benign, but if we do it for all copy_to_user()
> we better return ENOSPC to differentiate vs EFAULT to tell user space
> to fix itself.

Okay, I understand the preference is for a minimal patch to implement
the fix. Just to make sure I fully understand your suggestion:

Are you proposing that we add a single check at the entry gate in
`bpf_prog_query()` like this?

```c
static int bpf_prog_query(const union bpf_attr *attr,
                          union bpf_attr __user *uattr, u32 uattr_size)
{
        if (uattr_size < offsetofend(union bpf_attr, query.revision))
                return -EFAULT;
        ...
}
```

If we implement this, I want to confirm if you are okay with the
consequence for legacy cgroup queries (e.g.,
`BPF_CGROUP_INET_INGRESS`):

1. Before 120933984460: Legacy userspace compiled years ago with a
40-byte `bpf_attr` layout (ending at `prog_attach_flags`) regularly
queries cgroups passing `size =3D 40`, and it worked perfectly.
2. With this check: These unmodified legacy applications will now fail
with `-EFAULT` on newer kernels because they pass `size =3D 40` which is
less than 64. This means all user-space applicaion is expected to
"fix" their code when along with the kernel upgrade.

Is your preference to explicitly fail these legacy `size =3D 40` cgroup
queries (breaking backward compatibility for them) to avoid "partial
and inconsistent queries"?

If we want to keep these legacy queries working safely (without
failing them and without causing memory corruption), we cannot use a
single check in `bpf_prog_query()`. We would still be forced to plumb
`uattr_size` to `__cgroup_bpf_query()` so we can conditionally skip
the `revision` writeback when `size < 64`.

Would love to get your confirmation on which trade-off you prefer
before I send V2.

Thanks,
Yuyang
