Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793764147;
	b=HWFHEV0Wee/j2mac5OmgSpiPYXJxBVwO7HXf9mCWi1biaLyZ7ehRYTCAcfIry7v2o2kS
	 qX+ff+kGgCvL4ubEOqWgxlaDZgtSZZEo54Ho+ntxxucX7CSi+7+um91U7uJYpSESyyRJI
	 u3BkvyGmKukR5gvdU0zIjBWUbNLBPCFU+xZaBssWXd0GdvYuj8JBznbz1/kmRywxnrKPN
	 Nft0vieQ8IZifPrPzVQTTmLXcIsA4M5IMyG+1c2xGaUaKiWhLfjSGIrZxAm5iNmJxmCRs
	 fszeFUHo8SL/vR1Yc1sNGOA9t/lVoB66Y9hGDIfr8m6HlyXS8wHlxGQ1Lq8V7ZgKg8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cKWjRS9Xq/l8hl3060rXc9wXNrOk8HsfCBzOk8+AuV4=;
	b=T3i8IRoEuK9+FJa1WYF5IC9WyiXuk8pOzO+3+yqsFtdAzrhj6HYcxirrmO0iH0UOSVdZ
	 gB1odMlGWwLDjhLasQvzpS7yUeELlWLnwbKxTKENCdhzSGDkAlK6V0CeAtKdweB8iJwM6
	 Zsdx9qnbxVAqQOaoOzjcLdC02kEkN3POidh2C18yfQzvHmgL4bQhso9rvLEeJfdV8U+kU
	 WAhKk2XiyyzZqv2UES0hoG2/D4ZIok5QrThYOCR+btNZW+NYtDUTGRv2R3YT3Cn2e8NMI
	 HxtY0o3ICjXjgunMw/r+kIqPyaAbcVLry4RYkpVsEF8+17r4iCRnlO8jgaJmycTWp5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Zff7lCr/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301FC606A32C
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 03:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 301FC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Zff7lCr/
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533202fe429so154991cf.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 19:49:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793764145; cv=none;
        d=google.com; s=arc-20260327;
        b=BUL2pTLSwsFhb1s8D0/fOAMcLHahHMwChxclYTpiIOUtAK/IWn6IZuaTjGtmp9jtP7
         STveNwljIomxsY7ScxYtaVs9p4K2V074orDtzO2BAZM1ETRTDpivl/ohx8KjulGV5hGb
         tpleYd0rHE9G0Nk29lxtSCKTYRkSQ+/uK1EntiNuP2XuNHXi0yu/tGO8vk6AYKjMRLoZ
         0K9K/Ketp+GRugw5RkYUVh58DE156bJY6s6X5czBcIDl9Y4D9EPEoPBBsHBREEV6YZoJ
         YvBFjc8mZj0p2U0Ixlt6qOrOzJ0fLaKB8p3IsLUxldv54drLzTnqz0lAUQrRTQOeQzkb
         YwGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cKWjRS9Xq/l8hl3060rXc9wXNrOk8HsfCBzOk8+AuV4=;
        fh=INvSO/Q4gn4Jtt/gsPOC3W55IugdhnCzGE2Mogb5vhc=;
        b=UUhZLcu8FPMuuSvTbb6/Eto75LKrnkO4OD9YEGEmgbyWQYkWl5S+1vb7ApBg79Uo41
         TfEJ2l+Pzgta0e5oCcuvVajF0aAUuHt1YXbsFH7JadPqqSpS/WrMts5ImDijm5ihwcc8
         /nsDlVl5NLuLly6rNiDzxKxvf0iAAHd2VyoOLt7qVUrjfG9Wrxve6TWy3rY6CBt+D02q
         33+pnsZv1QLchjYkxrnmr5gGwAEuKVbPMdMXbQ6nqMVreCZ5XECG24qVV8HK6Mtmp7t3
         8ZXYZS++hP6m/mB6HKeMs/3TNapR4AOLEUpMbXOhAEQOnkJZJ5GuERmuSG3I87h7QJ2H
         KV1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793764145; x=1794368945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cKWjRS9Xq/l8hl3060rXc9wXNrOk8HsfCBzOk8+AuV4=;
        b=Zff7lCr/RYzDOMb26mR07xi/YgRsLCknrcp7xuB7uYbEei3iXUJHgJAMS5sDc9s/p3
         e5VGpX9uTqFK3Wdv5gDPAQxvyroQYQfHwlWZlPA58bsPYLpTlyfBcRF4WalCLlkbFevK
         VSjvYCAMvny47vCLyYeWEr0vylVwhyEkDw0z5B8YPPpXD1zmHK9kWfoVCm+6uPTiWp4W
         2jN/qeIPx4hx78uKvP0NOTWfQepDmHq1Pln6bOhyt7nqhnVPCkbcsmrYHjX93TUtWnIh
         RcY3+kfHuG2RPAAWQ7dhhfhgP6QZ4/o2h/vMA3mI4hrEvYdwmBXODg8YOv8Ybn8qgR37
         8TSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793764145; x=1794368945;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cKWjRS9Xq/l8hl3060rXc9wXNrOk8HsfCBzOk8+AuV4=;
        b=TcLjJJAxkW3gGgpCkKq8xJR33OQJMmUg4KBBojCDEMxSJcdWxZYK7Mo9U58wWFMAoJ
         VdXSzeNmn18MlX/A8P9a7Tx7EQiOJ2SRINazju9aJmMqdT+oebU92joJudR0bzNPXxq7
         5MYp2W7HJuDhoO5O65b5F0l8hOqkcOkvcvyjqvxPTkVStYByTg6sxGpImuDoTqaN1rQN
         2SZS8rH1Ge2OidJuXhlgbVesiPeuPzUgWvQd/7o7uIRtAiD6ruJ0P2Bld+weZcpLmeMb
         Z0MrOEuJLOFAJPOV8rQmpTHOc1tMLqkTDCWXGzeNA8JhmVyyqV2ZNqrI6JLFf+molRUl
         Kvmw==
X-Forwarded-Encrypted: i=1; AKwUvBx4tOCo3gF5eiDysrPaXULxRik6EsPwyiT3RPcE+3Nph/zIKUrKpPemiHlF76Ao/uOg2Ws=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ozPhwth/eOE9L77/zC9w6xJ44cMEOYgePFEvBWJ6IrJm0+DeR
	5bDfC1cqZhGIhxxS5cooDSSJwPs/a4uZmF/DjJC9HamaU11UR+X18bzXS1jLx//tobDmerTi9+H
	F/jlo21yzlPR7t9e8SXECqb2TWblCwoyFjReohESs
X-Gm-Gg: AYBFou3zJvaK2YrnvZtM/Bt/nm7M7foUZRjnJMEiVWVdfweNmyaC8ZKdavyGqi1ennp
	mw0LDCLYnqOX1cGXHzGESBSjbbbHYXjUY2FdvRjTzAX3HhP+6MS0UnE6cUGMWIMwVV8Uhsqo2Gh
	+zSX3jikmsI4SFy5SJzwWOHj1WzWv+j67NME0mCKilVDJTfIIufq+o8DnD8AxgpnvnH4r+KFlAI
	7qxyLsBb5BTmdrHGVlibugZTZV8YzMas0juvPjdEL4gnCf6fkUZA7x1AA7sr+hLjt7ET39W0c/b
	o48GuXe/jylG3bQO4z5y4G0che/ShmMi8Nvlv9eaWGPfVj7xnHjUdnvYFEu1Uj5ZkR+Dn2gYrDZ
	7aynn7fY9hUvONo0P6A4RXEjYpe8WSwykdsGClQ==
X-Received: by 2002:a05:622a:2298:b0:546:92f2:7830 with SMTP id
 d75a77b69052e-54b61e27b15mr3087041cf.6.1793764144251; Tue, 03 Nov 2026
 19:49:04 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030202710.3863806-1-irogers@google.com> <20261030202710.3863806-4-irogers@google.com>
 <25216bda-7e36-4bad-ba7c-1984dbb9dfda@kernel.org>
In-Reply-To: <25216bda-7e36-4bad-ba7c-1984dbb9dfda@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Nov 2026 19:48:52 -0800
X-Gm-Features: AclHuK8jUTP0fZRLAUdhb4V7KjnS7XAslg-dpWxyxMmrVUFMhhemkzjXApXA5fA
Message-ID: <CAP-5=fXKeqy75_1p9TgrqOgw_Eh8h=U5FB40PQbZhwxczV-CrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] bpftool: Prefer zlib-rs over zlib when available
To: Quentin Monnet <qmo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:20=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> Hi Ian, thanks for the v2,
>
>
> 2026-10-30 13:27 UTC-0700 ~ Ian Rogers <irogers@google.com>
> > Add zlib-rs and zlib to FEATURE_TESTS and FEATURE_DISPLAY in
> > tools/bpf/bpftool/Makefile and use feature_rust_lib to configure
> > ZLIB_CFLAGS and ZLIB_LIBS when zlib-rs is detected (unless disabled wit=
h
> > NO_ZLIB_RS=3D1), falling back to -lz.
> >
> > Decompression of kernel configuration (/proc/config.gz) and compressed
> > ELF/BTF sections (via libbpf, libelf, and libbfd) processes data that
>
>
> Is there any mechanism in place that prevents libbpf, libelf, and libbfd
> to link to different versions of zlib (zlib vs zlib-rs, I mean)? I
> imagine you could have bpftool linking against zlib-rs, but the libs
> installed on the system linking against zlib? Also I think the static
> build with the LLVM disassembler [0] passes -lz -lzstd in LIBS and I'm
> not sure how it would combine with the change, I need to take a closer lo=
ok.

Thanks for raising both of these!

1. On preventing libbpf, libelf, and libbfd from using different zlib
   implementations: in libelf.so, libdw.so, and libbfd.so, the zlib symbol
   references (inflate, inflateInit_, inflateReset, inflateEnd, etc.) are
   unversioned. If we link libz_rs.a with:

     -Wl,--whole-archive $(LIBZ_RS_OUTPUT)libz_rs.a
-Wl,--no-whole-archive -Wl,--export-dynamic

   in Makefile.rust (perf already passes -export-dynamic via python-config,
   so adding --whole-archive is actually important for perf too so it
   exports the full zlib ABI rather than only the objects referenced at
   static link time), then ELF symbol interposition binds all zlib calls
   from libelf.so and libbfd.so directly to zlib-rs in the executable:

     $ LD_BIND_NOW=3D1 LD_DEBUG=3Dbindings ./bpftool version 2>&1 | grep in=
flate
     binding file /lib/x86_64-linux-gnu/libelf.so.1 [0] to ./bpftool
[0]: normal symbol `inflate'
     binding file /lib/x86_64-linux-gnu/libelf.so.1 [0] to ./bpftool
[0]: normal symbol `inflateEnd'
     binding file /lib/x86_64-linux-gnu/libelf.so.1 [0] to ./bpftool
[0]: normal symbol `inflateInit_'
     binding file /lib/x86_64-linux-gnu/libelf.so.1 [0] to ./bpftool
[0]: normal symbol `inflateReset'

   That ensures libbpf, libelf, and libbfd all use the same zlib-rs
   implementation at runtime, and means all compressed ELF/BTF/debug
   section decompression in libelf and libbfd also gets the memory-safety
   and performance benefits of zlib-rs even when linking against distro
   shared libraries.

2. On the static build with LLVM disassembler: `llvm-config --system-libs`
   emits `-lz`. Since `LIBS` in bpftool (and `EXTLIBS` in perf) already
   includes `$(ZLIB_LIBS)`, we should wrap `--system-libs` with
   `$(filter-out -lz,$(shell $(LLVM_CONFIG) --system-libs ...))` so static
   LLVM builds don't pull in `-lz` alongside `$(ZLIB_LIBS)`.

> > benefits from a memory-safe implementation. Preferring zlib-rs over C
> > zlib provides memory safety and improved decompression performance whil=
e
> > keeping bpftool aligned with tools/perf (including sharing libz_rs.a
> > when building bootstrap bpftool for perf BPF skeletons).
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Recalling our discussion from v1:
>
> >> Hi Ian, bpftool doesn't make an intensive use of zlib (mostly, it's a
> >> requirement from other dependencies; we may also use it to unzip the
> >> kernel config on the host if necessary for probing BPF features on the
> >> system, but only on some distributions). So I'm struggling to understa=
nd
> >> the motivation for your proposal, what do we gain by switching to
> >> zlib-rs when available? I understand this implementation is in Rust, b=
ut
> >> I'm not sure the added complexity and feature probing in the build
> >> system is worth it.
> >
> > Hi Quentin,
> >
> > At my workplace, we are transitioning from zlib to zlib-rs for both
> > security and performance reasons. I'd like to keep upstream tools
> > aligned but they don't have to be, it just seems nice. I agree zlib is
> > of a lower priority to users than, say, zstd. For attackers, like with
> > brotli, it is probably an area of interest. Knowing the implementation
> > is memory safe is at least something in favor of zlib-rs. I sent this
> > series out as an RFC because I obviously have no way to mandate what
> > upstream should or shouldn't be doing. There are things that can make
> > life a little nicer and easier, and this patch series, for me, is one
> > of them.
> I understand you're transitioning to zlib-rs, but the current patch is
> not a full transition, in the sense that it doesn't replace zlib with
> zlib-rs but allows any of the two options; and I don't see support for
> the standard zlib being removed from bpftool anytime soon, which means
> that in practice, we've got to maintain compatibility with the two
> versions going forward. Others may want to chime in, but I'm still not
> convinced this is worth the burden.

Because zlib-rs (via libz-rs-sys) implements the exact C zlib ABI and
headers, there is no C code difference to maintain between the two=E2=80=94=
only
the Makefile selection of ZLIB_CFLAGS and ZLIB_LIBS via feature_rust_lib.
With the symbol interposition above, bpftool (and perf) get memory-safe
zlib decompression across libbpf, libelf, libbfd, and libLLVM whenever
zlib-rs is installed at build time, while still building everywhere else
with C zlib.

> You also mention zstd, do you plan to add support for a zstd alternative
> as well in perf and bpftool in the future?

No current plans for zstd. Unlike zlib-rs (where libz-rs-sys provides a
complete, drop-in C ABI for both compression and decompression and is
already packaged in Debian/Ubuntu/Fedora), I don't think there is an
equivalent drop-in Rust replacement for the full libzstd C ABI yet
(ruzstd is currently focused on decoding, and the zstd crate wraps C
libzstd).

> (By the way, if you allow me a short digression, you had a patch related
> to the zstd probing for perf and bpftool [0] and I don't see in the
> tree, do you know if it was ever merged?)

Thanks for the reminder! That series wasn't merged yet=E2=80=94both you (on
patch 3/4) and Peter Zijlstra (on patch 4/4) gave Acked-by on v2, and I
think it fell through the cracks waiting to be picked up into
perf-tools-next. I'll send out a rebased v3 with your and Peter's Acks
collected.

Thanks,
Ian

> Best regards,
> Quentin
>
>
> [0]
> https://github.com/libbpf/bpftool/blob/main/.github/workflows/static-buil=
d.yaml
> [1] https://lore.kernel.org/all/20260909204122.1993010-4-irogers@google.c=
om/
