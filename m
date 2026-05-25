Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0B37269F
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693740; cv=pass; b=rz9jB56J/i7NIvK0YSXvz8SsvmhSAd/twj4hD3ebROUI3Nr9KuEQDBzWzmn9Zg66X6g4NanRtGzuKOHJqU8foDKbnhJORbNzkFZGQeH9fUC40ggtt2RJtPKpTGX9i3Co85ADYC+zF8eA3rO9a2BP7Cd2VYvg/Y4NmVeTUGzmMG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693740; c=relaxed/simple;
	bh=X+7djYcP9GEagwqG8m/X7AI21c2H+orZX9PlTDd1uts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkiBE6zPTLz12YXCgDqenO2G+mcw8CtOXv344wd1iCc/GXBIApRyD4dVT9J2QXXAqgXmWw+YGy41MrI4o49GQQjff6Uz5Dvq9d162JkSMNKACOONEdmpaV1luteqd2G+A6Kgv3ldKLpHUQM8RaGGF8dau7pSOcnNxOzTKjx6J3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isONnAqh; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isONnAqh"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e61648f10so1051cf.1
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 00:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779693737; cv=none;
        d=google.com; s=arc-20240605;
        b=jaza/2y0nOJKw7IMkiUBtxnm2VNNn9+94mgmxEpwhQqJzn5mbrnCs0iEk15qfbfxDs
         ATsgwe172q93P54AlPH4Z+fbF6yEdzymSCmU0U8httQYDbDlXBtrABvX/2yLkkV9YMCJ
         1VmgYPvbLbc1j5Me8HFzE6HvpqE8bVV9IjZMZzpk0+kIh9S1RolRgzwatCUeI4O3dbGi
         mTY5lejN509kURRQ5EpIk2VoobOFUPb4ngO2SldAI8Sqeq8pfA6iQSzf6dkZ0t5J8H+U
         HBEekogOHC1xUiRIZdW0ofXBjam57vqmpgvNXIYgqbIuP+kDmDFWairWfptFx26kybhf
         v7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y5njTe4srkYzXCM80V2lfRLC7p2SgEf5NieyXgBYSB0=;
        fh=JyBeejJA1nKTdVrqhEdO3Q2ZwQZnFzkyUNHPk1e7CUM=;
        b=RghiXa+AdK4vWuONw4R5urCg4g5DEOREWTS4z4vhhARAB6SqpkhGfpR35HtOmm6jK/
         zsta+54H/7oJ02AIW4HidTe78yDldtX213b2tdnYW/dvCzoV07OeivIgkxIj50IkYq8o
         itudMaFlgkZO+IKth10L3FixrBZEnbqJZnvUCSKm3SyBmmhpf1cZvfJQ6nNAyH6x9qgr
         bnT5VZAeXSeE5G1vv+W1wTqFKaMA3vVOGDsgrJPXJ445n5PkM4R2iM1SVm0i2EQuOg6I
         FNxgL5jJvFQJn4NfnYnWaReTvL2tEZ/8oEV3iClilMGLvwoSC3M7PeGkmfouFIRqR4bQ
         3aXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779693737; x=1780298537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5njTe4srkYzXCM80V2lfRLC7p2SgEf5NieyXgBYSB0=;
        b=isONnAqh/ZhFsy6iD3c0a5inviOt5HqsXTnZWM01VwETIIWEd7Xs7w4ClY/v5tk3qR
         ShhBHUSTJ6cUqWA0lfQf/EQJSS2p3nrsrRWw5lu/LlUuK6rjTQ83bdAgx2WaisJkTHBe
         q2OgtwWlEa43NSx4KyNH9xowkRwShBATXk+NQzNC8hMfOYWgE24q8V6IQ3cUAiyxz8PP
         QHblTQOFma0lLa9BLf4El6zl3LVLpqhWqvYXoBD6EAWm7zZHMItrwJvbLtOBCHcCF//x
         aSfXtMcEngjmGWl2TkJvjxA7PXfQe5gLULzGRV/RYDd+FqGGNWRY2KGrs/+H8ZllbqFu
         0qWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693737; x=1780298537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y5njTe4srkYzXCM80V2lfRLC7p2SgEf5NieyXgBYSB0=;
        b=kn+3A87ZAxiSsqVc+rWrTdjiH9kImEuVy+ZjFoT6clf/S7WWnj3pBmnMyJ2U93u3TC
         KJ6RUgx9zF9/wKarXURYnrcEvb0/mEw44OYlYqkpIajVGuFb6vFTvmygYDmg3pQvsvft
         luVUUgp5zzdVGYaNbrXGQeT7oNBNUxr4L84fiN9L24t4r8FiWRhWZpNiXMoqyq4HpgXR
         ywI2c3IQcwUSEhsOaPfw4msKzgecLnlNYRRXNzunSDmcBXLqoxOKeq0WcPM4M/ybkP4B
         RMOsnSaFcE47si7tvubld603hb8KVz96emhf+LnBq+aDFn6pDIXViCwHGORZwnMLNOka
         KLaA==
X-Forwarded-Encrypted: i=1; AFNElJ8jmHGyhYs1BHFArwNZ/BHM+IBHjD35EaEkt0n9Tc1ujllFfuRieA9TfKUxc9YEoS7pAKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkEZ2I8F5Xxs8eoLL/gVWKNGxegvcwLeZpv0gUfXhWC7YPoeii
	ibxOddpXHDL2fYC8SZE0kP58PXCK898AyIhrHRC1WiNdBnjrr4989EH9oRgsD5BZ73Aa8BsLbML
	TGXY/PS3ouKDMlysjhrqJhQ1QGgwiuaRkRrWFT6at
X-Gm-Gg: Acq92OGDfp1MklkI8Y6SrWaBMzsFBp0P0KgkObNP3HBFknsNmrHtE1/OLqB3UhetKYk
	DB5PCmLwaeZMrN8ldd5NX0udw2K7LUjI35L+8YGnE7JJagPL2SwQf6009vMms8/yWfRp7g2oY+a
	fkaCTkyU3xKL3K1XgoHgE90SW6r3DUZRCD+NCoMnR9zf6h6HcQs+4eDW1fh2rTcSeSYh5L2u7as
	PernSi2hCr4HWqi94WbUC85omvLBmciCQMbHro1k8gd5Jg88v6son10/tEIKuWpb7dkpJWPNfIg
	yXq5Qs3ir3/cd7IlKA9Rf77uEPVQiSLY1t63fPUIc34sEBq3TUDHldtpFFfhSIrQ4HyrOTSpwOR
	SEVE1mg==
X-Received: by 2002:a05:622a:201:b0:50e:595d:164 with SMTP id
 d75a77b69052e-516e0cf98d8mr18186391cf.8.1779693737022; Mon, 25 May 2026
 00:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com> <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
In-Reply-To: <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Mon, 25 May 2026 16:21:41 +0900
X-Gm-Features: AVHnY4JA9Kqb5fOY7fSO1LmnGe3xgrK64F2oWnLs97m99yzTrV6-pG4BIKgY5OA
Message-ID: <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
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
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review comment. To better explain the problem, please
bear with me through this long email reply.


>AI is wrong.
>The fixes tag should probably point to 053c8e1f235dc or a subsequent patch=
?

Thanks for pointing it out. I think the correct Fixes tags should be
as follows, and I will split them individually in the v2 patches:

Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi-pr=
ogs")
Fixes: 120933984460 ("bpf: Implement mprog API on top of existing cgroup pr=
ogs")

>Please provide more details.
>I'm still not convinced that what you're saying... is a kernel bug.
>Looks like user space is querying new attachment types with old structure.

I created a small C program using BPF_PROG_QUERY to query
BPF_CGROUP_INET_INGRESS (not the BPF_TCX_EGRESS) to demonstrate the
full problem , hope it clarifies:

```c
#include <unistd.h>
#include <sys/syscall.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>

#define __NR_bpf 321
#define BPF_PROG_QUERY 16
#define BPF_CGROUP_INET_INGRESS 0
int main() {
    char buf[64];
    memset(buf, 0xAA, 64); // Set 0xAA signature
    memset(buf, 0, 40);    // Zero out legacy 40-byte struct
    *(int*)(buf + 0) =3D open("/sys/fs/cgroup", O_RDONLY);
    *(int*)(buf + 4) =3D BPF_CGROUP_INET_INGRESS; // Explicitly set attach_=
type

    // Call BPF_PROG_QUERY (16) with legacy size (40) on x86_64 (syscall 32=
1)
    long ret =3D syscall(__NR_bpf, BPF_PROG_QUERY, buf, 40);
    printf("Syscall return value: %ld\n", ret);
    printf("Revision (offsets 56-63): %016llx\n", *(unsigned long
long*)(buf + 56));
    close(*(int*)(buf + 0)); // Clean up cgroup FD
    return 0;
}
```

Before the patch:
  Syscall return value: 0
  Revision (offsets 56-63): 0000000000000001   <-- Stack/Heap Corruption!

After the patch (Safe / revision writeback is gated):
  Syscall return value: 0
  Revision (offsets 56-63): aaaaaaaaaaaaaaaa   <-- Safe (Signature intact)

For this example, the regression lies in legacy CGROUP queries:
1. BPF_PROG_QUERY for cgroups is not a new feature; it has been in the
kernel since 2017.
2. There are existing legacy userspace applications and language
wrappers (like our android net-tests) written years ago with older
structure layouts (passing size =3D 40, ending at
query.prog_attach_flags) that query cgroups.
3. In June 2025, Commit 120933984460 backported "revision" support to
cgroup queries, introducing an unconditional writeback in
`__cgroup_bpf_query()` at offset 56:
```c
// In __cgroup_bpf_query() (kernel/bpf/cgroup.c) - Introduced in 1209339844=
60:
if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
        return -EFAULT;
```

Now lets talk about BPF_TCX_EGRESS:

> bpf_mprog_query() and tcx_prog_query() were only introduced there.
> How come your userspace passes shorter uatter to query newer
> BPF_TCX_EGRESS attachment?

I understand your point, but two common cases exist where userspace
will legitimately query BPF_TCX_EGRESS with a 40-byte structure:

First, a generic BPF querying tool (assume it called `./bpf-query`)
compiled in 2020 (when the query buffer size was 40 bytes) might
accept the attach type dynamically from the command line:
  ./bpf-query --type 47 --fd 3  # 47 is BPF_TCX_EGRESS

The unmodified 2020 binary populates the struct dynamically and
invokes the syscall with size =3D 40:
```c
   ....
   attr.query.attach_type =3D 47; // BPF_TCX_EGRESS (passed dynamically
at runtime)
   syscall(__NR_bpf, BPF_PROG_QUERY, &attr, 40);
```

Without the size check, the unconditional writeback of revision at
offset 56 would result in an out-of-bounds write on the stack.

Second, in dynamic language environments (like Python), UAPI
structures are often declared manually. The developer might only
declare the subset of fields the application actually uses (40 bytes
in this case) to optimize memory overhead. Even with this subset
declaration, we believe the kernel should ideally respect the declared
size limit to prevent accidental out-of-bounds writes into adjacent
userspace memory.

> Looks like user space is querying new attachment types
> with old structure.
> Potentially the check can only be around:
>         case BPF_TCX_INGRESS:
>         case BPF_TCX_EGRESS:
>                 return tcx_prog_query(attr, uattr);
>
> to be nice to broken user space,
> but, really, attr->query.attach_type shouldn't be equal to BPF_TCX_EGRESS
> with a smaller uattr.

Add gating to the TCX path, will not be able to fix the legacy cgroup
query path. As shown above, the cgroup query path has the exact same
OOB writeback regression affecting legacy userspace. Since we must
plumb uattr_size to cgroup.c to resolve the cgroup regression safely,
applying the same consistent size-gating in bpf_mprog_query() seemed
like the most consistent and robust architectural path.

Feel free to let us know your thoughts.

Thanks,
Yuyang

On Sun, May 24, 2026 at 8:22=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 21, 2026 at 1:41=E2=80=AFPM Yuyang Huang <yuyanghuang@google.=
com> wrote:
> >
> > >This looks like a bug fix for an out-of-bounds write vulnerability.
> > >Should this include a Fixes: tag to identify which commit introduced t=
he
> > >unconditional copy_to_user() calls for query.revision without checking
> > >the user-provided buffer size?
> >
> >  > Fixes: 3fe213c040b3 ("adding ci files")
> >
> > I completely missed this checkpatch comment. I will add the Fixes tag
> > in v2 if there is a consensus that this patch is the right approach to
> > resolve the issue.
>
> AI is wrong.
> The fixes tag should probably point to 053c8e1f235dc or a subsequent patc=
h?
>
> bpf_mprog_query() and tcx_prog_query() were only introduced there.
> How come your userspace passes shorter uatter to query newer
> BPF_TCX_EGRESS attachment?
>
> Please provide more details.
>
> I'm still not convinced that what you're saying:
> "
> For example, our Android net_test  suite uses this legacy 40-byte
> Python ctypes struct layout:
>
>   # legacy 40-byte layout (pre-revision field)
>   BpfAttrProgQuery =3D cstruct.Struct(
>     "bpf_attr_prog_query", "=3DIIIIQI4xQ",
>     "target_fd attach_type query_flags attach_flags prog_ids_ptr
> prog_cnt prog_attach_flags"
>   )
>   # Invoked via: syscall(__NR_bpf, BPF_PROG_QUERY, &attr, 40)
> "
> is a kernel bug.
>
> Looks like user space is querying new attachment types
> with old structure.
> Potentially the check can only be around:
>         case BPF_TCX_INGRESS:
>         case BPF_TCX_EGRESS:
>                 return tcx_prog_query(attr, uattr);
>
> to be nice to broken user space,
> but, really, attr->query.attach_type shouldn't be equal to BPF_TCX_EGRESS
> with a smaller uattr.
>
> pw-bot: cr
