Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62073413220
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742895; cv=none; b=iES0oHpxHehfUwHg6J43bj672plPOgU6yIxV/dfPcPh3e+eftpl03sADkKuUVdgDMPBb+UCqwJ8yxbQ8r2TA1UfH9w0xDHafJjbvjMigiP01TUrdwc7RIYhEb//wLBL9P0Z9B3x5AcjxxmvmOAEi6lGWJrk0Zwh5iKk7l3n+quU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742895; c=relaxed/simple;
	bh=6N8TZdOGZpYdvkdEzYl4kczOMe5OzzYX7K8rWlif55w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+rMcqhQ6ypciRNnzC/0tZ8RlQVXqN4vwfebd6ifYZ+DBjTsTBZe7Fa1yAwRIXdPCM4GbqAQuQeUzWhB5KLek/ZJfjmZ/+yvTWIHjaaOmjaRj275NAs4+LXTzmSuy8u+bZy3wgBOwYGUwE45MnZuRuvrPYboqYl+HajUQPzqtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvQnH6MT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvQnH6MT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8B01F00A3D
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782742892;
	bh=6N8TZdOGZpYdvkdEzYl4kczOMe5OzzYX7K8rWlif55w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RvQnH6MTIBL/G8eXLoFHj7YZth3vXHgnVDXJCKfbDeZp6RXJ3BXCLE0grbrZzyii9
	 /yS+oreF3/8JQ0puL6llRqgTg/xs0Cq6sBDFGYeEx0Jn2TNR8YyXcwWfx7IFN9yhDc
	 LAeHBiDlmOvu5L0mCxDtz88UL3GCczmBaYd7WLSbKcWud45EtrT6OBPZlaK5rm+Blh
	 EXN6Mz8LoFkMbpJlxxk1YxWVGragpChsvDFhry132uDN5YZ65ejpW5hQOSCugXRW/E
	 eru4jKMDGMjr0kdGORU6W4odDhBapVkVRXRIO6N1HFgDXjeiME51cqnc6Ow4xWVIZI
	 jd0YuLgRbDZCA==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5cb052edso43448985a.2
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 07:21:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YyULi/QhouA6+3IytSBvABgSMSgnEQPoIJD3eemn5EJd6ZPDx0D
	c6gRk3EHWFkXXbQK2+iBq3K/4PVIzkVF3RpPdHrNXY6KcxdWOL3GstuM8w0w9QTzOJNublkKdz5
	HXVxCd5/CpTUe5F12GJCmGWAi4GL/rGk=
X-Received: by 2002:a05:620a:29ca:b0:92e:56f7:c5fb with SMTP id
 af79cd13be357-92e56f7d387mr348831685a.12.1782742892220; Mon, 29 Jun 2026
 07:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629140048.733346-1-pulehui@huaweicloud.com>
In-Reply-To: <20260629140048.733346-1-pulehui@huaweicloud.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Mon, 29 Jun 2026 16:21:20 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNhn9eK+3xsd3ewEsG-duCgBeYXeLAtNan=qefas2Ya0dQ@mail.gmail.com>
X-Gm-Features: AVVi8CfLeBnCl8UWbgTGDyVcouBIu1AOkUzgbXfQlr0DRYJvmC-HJ0Ezdj90Wog
Message-ID: <CAJ+HfNhn9eK+3xsd3ewEsG-duCgBeYXeLAtNan=qefas2Ya0dQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/6] Mixing bpf2bpf and tailcalls for RV64
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey!

On Mon, 29 Jun 2026 at 15:56, Pu Lehui <pulehui@huaweicloud.com> wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
> the TCC can be propagated from the parent process to the subprocess, but
> the updated TCC of the parent process cannot be restored when the
> subprocess exits. Since the RV64 TCC is initialized before saving the
> callee saved registers into the stack, we cannot use the callee saved
> register to pass the TCC, otherwise the original value of the callee
> saved register will be destroyed. So we implemented mixing bpf2bpf and
> tailcalls similar to x86_64, i.e. using a non-callee saved register to
> transfer the TCC between functions, and saving that register to the
> stack to protect the TCC value. As for the tailcall hierarchy issue,
> inspired by the s390's low-overhead approach, we store TCC from
> RV_REG_TCC back to stack after calling bpf2bpf call or calling orig bpf
> func in bpf trampoline.
>
> In addition, some code cleans are also attached to this patchset.
>
> Tests test_bpf.ko and test_verifier have passed, as well as the relative
> testcases of test_progs*.
>
> v4:
> - Fix tailcall hierarchy issue.
> - use is_struct_ops_tramp helper in bpf trampoline

Alexei outlined some (major) concerns on the whole mixing side of
things [0]. I haven't been following that space -- did Leon have a
workaround/fix? Can you explain more how you fixed it, and why it
would make sense to add it to RISC-V now?

Thanks,
Bj=C3=B6rn


[0] https://lore.kernel.org/bpf/CAADnVQ+rLneO4t=3DYYmLYtc945Fz0=3DucNTWZBxg=
vs8toFY-onRg@mail.gmail.com/
