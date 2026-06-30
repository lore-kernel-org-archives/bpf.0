Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BFF3D8915
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782850532; cv=pass; b=J9lhsMr0bgmAIp8GWV3Cm2BT+SHchY/sagwbzuu2jjKtfWWxMGdmuUOFLtDbm+G03wbnqka0r2l9dl7G8LD1gWcK5q26jeK1lJtby+mQNfXLgSs5TuN8YIzI9jqS0tmKX4nuxRKcmukEFjUbrCb718pMVgOSrH8jTVI+FXHTtg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782850532; c=relaxed/simple;
	bh=OwAKdd0lzhCkWFXMobBVgnQJ5SkkB2JFS1aU+VmYXmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISqdo0nHPyh0wpz9fyYCyx8kKnFU1MbuSGDJztZ3olEsMEUgqMtOnHZvsMhLcWW5qTdwBcff7PmnD8lnnpOYEE3ulyi+GBNNFBnTdD+DEahJ33fP7R4+rrDmJ4Vye5MqeTv/3vGNKgKr3b8gRYMuwpppIcJoeGKViSdUyJIrRM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDcF/4nW; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDcF/4nW"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38005a36edbso1504544a91.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 13:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782850529; cv=none;
        d=google.com; s=arc-20260327;
        b=KmPnMKrUab7DzvdhJjSG22YLVYwSmi3LP4vo/r+X7unNY+YUmAAYz5Pqc+72TYQH9i
         QqOi7286V0eTdeCADZezPg/b3f6+z3y1WV3psZ1iijMP6/HiMMF3elkONJwVui/JluvY
         JZ4jNWoi4mF4jmguurLa0Ab6QVqz9wewjUtb3ZrvHHcA8Ndx78Y6sXwQ2UIIdslLhC5E
         KJeA0+Cf4/h1DyD81+YQomcW5zHVH0y+HTfn3dTmjs0aLgm/sFoH8Ruq+tUe+a/6E67P
         O0qCEHLLvO09H0h8/m+ZB8eVsAxEnMJmmewjXkHk1phOFo+0DZuzO6vsbG6aW4dbUv+7
         gWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iv0xP4pesG8729zzu2wkUS8LY3d2Mut8CdprFZFiwTw=;
        fh=wWBUdzK/0woOrL+hjTPIwaRIyTAwLjB3Tvj5527uqe8=;
        b=AU5NaIpnzDBvKHVhMqHa6jswfoBdq+kvUyVT5aOQ0n6Xw938AQrnBYjlQYQ2DrkP4y
         oD4K1k4+4bYZ2EF0Ky9RB8jq5FSU9wPuod5/jfJUNz/mOnkvC3z5mZ3NysCc8/2gOBdr
         yCMx6MoOkb8wxrpb5TU9UnlJU6QxeP2fyKmhEET2v8zVVfpmfzX1HzyzFUqjShf3Cquh
         ni9W6WWObNjWNObHSxW7pnPwcoTrYAFFIrfQroS1m3P9o4bFHaXwO4J5UgBnJMifIO6L
         zeL1XYFXUWhrd1LDucKFv5YDgar5uVCACOnATFagYLUtigj4RkjkhJMMxsH6GuraBCFI
         LVdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782850529; x=1783455329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv0xP4pesG8729zzu2wkUS8LY3d2Mut8CdprFZFiwTw=;
        b=JDcF/4nWonLI9FivC0YJJGvKSlx8wZqk8ecbl5geAH7XtkFnEo8cxxn4b6zohrHkH2
         zarpAu+ojWCiKSMm8Fz+bv5RcEMCB8FGHZ3BP2I6m+g8/888VpExdh8+GcWxBMXuWSuD
         s7igsG35ivf7SzzYASVhSk1SRr6hfEHRUgStOnDoerJBIVVoG+8n7EL7XCqQK55qoQI+
         zOg8BJo3k86OGhJB/SuVniL/7b4mUvpgxsd5DNIMp7BSHdxud9/0XVHh9SfXxntzafyN
         2AIEv23fqi+00n9FgEnFikBdIWSUZ3EjwD/DHxBBa72+DrzNT8uclOkhEgI5LPtZZyKz
         WZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782850529; x=1783455329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iv0xP4pesG8729zzu2wkUS8LY3d2Mut8CdprFZFiwTw=;
        b=NEcaE6ReAGyMoBnpbFgwAK7RpTcJ51ZZyoRbIxEzZbxOtpMQION7NA2yiMirIEGS0N
         nDQqKKwEPI59cBQylO0MjrtyVpUZ/xBjoJ2AzYm8dbYBgaWUJiCepmwxdawG7KwwOStU
         igSS6eo6r0cq2NkTYSiaHlRzF5KnsSYMDmPuApeM45N6NNJRmAiiLrsmci0Eu65iV5Lq
         zlFVp/MH2Fz81tVEiclBpsZfP5VZ7Dl6kYMQ8/HFmiPNEraSfu9DuD2WKvh3f3ut1JOg
         33Do5REzUwl1cUY/I7RZwXvZHKoPPkI+ZA4UXZ2j5JRfyFslm5UxCOivXSdcvC2Z82nt
         6M+g==
X-Forwarded-Encrypted: i=1; AFNElJ9lHtChuV4tjTpMvX/ILg8JXWdlLZwCZGNFzJ8naiOIk+R2zF0tT1oba/p8198FlE+t6uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQJzs4o50KPMG4O2ekjjgBu0zAKwAnfJ2VsQqKC9nZk4Rh+W7
	At+PrvX/CGvHPZniJJgOFQVvuKrGNSRExIvpj5wE+WZND4KAqjrgglEPpwk3EXwrlHEo8zrB56C
	QbveOu8pygfQEvKL1K7B23ONhe2Y2SrbgN7sz
X-Gm-Gg: AfdE7clEASqQdTJCvGB+hDZjW+SiimbGZyzeQW5xI4IIFZFSxVQZrC5FbVwa8+BAJwr
	v0GPUgIB26B8ravFWkKkqiFymZuyhMrPwpfOgkDEcjNAq+VAqk9wYALB003xinAe5cLEyWxy6uX
	9Vg7vX2+iiR1QRw0fHdar/hAC1xVuhOIENyg86UGh/BJErgviRb47KrHyc7o18K2VyXn/zAeOtB
	Nm0Zx0w+AcLO3JLhQHqF2EAf1Rz8aWVh4rSp47f9BVyPWT2OHk3WaxRNiPog4f9ZDEVY+xrR/Nl
	Ovie4yDWp8qRrriivuQC06aheBz11xMJf/whEJ3RttkJnHi+FaeBGb4e+it+UZctYp47yB/i29Z
	H5iUv
X-Received: by 2002:a05:6a21:3983:b0:3bf:b704:42bc with SMTP id
 adf61e73a8af0-3bfdc2d96c4mr1724065637.10.1782850528634; Tue, 30 Jun 2026
 13:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624204946.2901178-1-andrii@kernel.org> <178248062788.457674.6865742035078097472.git-patchwork-notify@kernel.org>
 <CAEf4BzbUEi4zZxEBggHzbYRaSMtQ6wWJSjHhqfvE-omvGadApw@mail.gmail.com> <da07a0af-fbcf-4936-8194-1dc2d58bdf59@kernel.org>
In-Reply-To: <da07a0af-fbcf-4936-8194-1dc2d58bdf59@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jun 2026 13:15:14 -0700
X-Gm-Features: AVVi8Cc54ZLtVBB8V76yiPIZYM_UXoPTHS-011iEphLuHJMBy2seEkcgGc_N3Xk
Message-ID: <CAEf4BzaCbvsBePEaiHaCniXWUBhgDnJ99=XPL4idLY3_xkH3dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix -Wformat warnings from
 format/argument type mismatches
To: Quentin Monnet <qmo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 1:01=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2026-06-30 11:32 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > On Fri, Jun 26, 2026 at 6:30=E2=80=AFAM <patchwork-bot+netdevbpf@kernel=
.org> wrote:
> >>
> >> Hello:
> >>
> >> This patch was applied to bpf/bpf-next.git (master)
> >> by Alexei Starovoitov <ast@kernel.org>:
> >>
> >> On Wed, 24 Jun 2026 13:49:46 -0700 you wrote:
> >>> Building libbpf with -Wall (as happens via bpftool's bootstrap build)
> >>> surfaces ~120 -Wformat warnings where pr_warn/pr_debug format specifi=
ers
> >>> don't match their argument types: %d for __u32/Elf64_Word, %u for sig=
ned
> >>> ints, %zd for size_t, %ld for unsigned long, and %x/%lx/%llx applied =
to
> >>> signed values.
> >>>
> >>> Match each specifier to its argument's type where a correctly-signed
> >>> specifier exists (%d<->%u, %ld->%lu, %zd->%zu). For hex conversions,
> >>> which have no signed form, cast the argument instead (%x->(unsigned),
> >>> %lx->(unsigned long), %llx->(unsigned long long)). No functional chan=
ge.
> >>>
> >>> [...]
> >>
> >> Here is the summary with links:
> >>   - [bpf-next] libbpf: fix -Wformat warnings from format/argument type=
 mismatches
> >>     https://git.kernel.org/bpf/bpf-next/c/df3153758ddb
> >>
> >
> > Quentin,
> >
> > I synced these changes to libbpf's Github mirror. Can you please
> > update bpftool mirror's libbpf reference to include this change, so
> > that I can fix these noisy warnings for wprof? Thanks!
>
>
> Hi Andrii, I just synced it, thank you.
>

Thanks, Quentin!

I got a bunch of new ones with latest bpftool sync, I haven't looked
into it, but thought I'll mention in case it's something on bpftool's
Github Makefile side:

  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/btf_dump.o
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/hashmap.o
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/ringbuf.o
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/strset.o
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/linker.o
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/gen_loader.o
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/relo_core.o
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/usdt.o
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/zip.o
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/elf.o
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/features.o
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/btf_iter.o
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
  CC       /home/andriin/wprof/src/.output/bpftool/bootstrap/libbpf/statico=
bjs/btf_relocate.o
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]


> Quentin
