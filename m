Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06013DA7C7
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 06:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172240; cv=pass; b=LRTXRCt+qetpHIVtT1QlsR26JzUjta0sALfZxRcteO4ct3EqOJzK+gXHXOyrx/x7jY6UJIZ662+OxTo6QZHdS+/mfhVziGvweMONU3h8YrdoQiwtaJSKKcug5l03JpBMt32a9RON68vXTZP//y46gkXmLwq3Rg82iwU3hUMM8PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172240; c=relaxed/simple;
	bh=+woVYTlOGzYFlAfcuIumImhF/UTB3xf+E9zAYlzDmIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHMM8PM4yuKZaUNN1KpbVvmfxtVzjAGrXGE49Z+NvQUTn6p4bqefhQI57EksMV6RYZd8ZOYWiGZjRdh3WxGvXJjK/QzzLqL0VIWHFgCw0n2On5m+004Hc/1z82PHkcyxeh8GwBc1B/2g3FqhbMYARC5NKQxyq0+NLquctbOzIMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YF6NPr8F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLJuY3LS; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YF6NPr8F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLJuY3LS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772172237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xle5YbXN6KwFDRvCphlTjI+Jhqul262ibdvj3JnVvLE=;
	b=YF6NPr8FVhovyyk89x09LBuSYIwPj+JE4HTU8850wiRMeGGKdOSzhwxIKS2+Ns02UOV8Kw
	y8qUxs2W6jPunklqZ/0dZhRYpsNU21oDzIIrG2/KHfnaaZKD0XM8jPXXfkhnwhedudniE1
	5k4uNYUBLtj9jgivrKFlYwYYBLtNnYA=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-kzNpGXmKMDeyFIlxv8wy4w-1; Fri, 27 Feb 2026 01:03:56 -0500
X-MC-Unique: kzNpGXmKMDeyFIlxv8wy4w-1
X-Mimecast-MFC-AGG-ID: kzNpGXmKMDeyFIlxv8wy4w_1772172235
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so1681369eec.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 22:03:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772172235; cv=none;
        d=google.com; s=arc-20240605;
        b=gCt8RQeMw0YHn8xg6gULwgEsYOXvZM6g+4LVXogbWSIArcbcrvfXEV9fw31e318VXy
         wmjZYeKhK0VVxh7Zm7Ol69+uyFv+fmijZUzWqhdD0K1MV6YPYGWvKaLmk/c+li0jZOoI
         ouqEWKgFMXWcsp3Oq2CjiQYm5jBOwzHz0EG58LCMcfMNullyoVMwuM3ytGf33CbiNvf9
         dLMOu91yQI4wUDhJGfZIlHpdtnRgJBugnXiN2iP7JsNfU7BqiOF9nWpP0i3Ew0ek/qFY
         I9XhCTv4Bqo+1ewFbyqfxOI91BXWMxK9SJ7YbTfLP/4TVLnXCjbYKaGH0gldkg1I/opc
         1s0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xle5YbXN6KwFDRvCphlTjI+Jhqul262ibdvj3JnVvLE=;
        fh=vldbUtds0rwtEe4EDhJTPTReJkcRajI0lGW0vy2WRAQ=;
        b=X37TMpWxwHaTYwMsU+0JnjtW4FUNqd+GS6cBd5QfI/ommC+/SkRfYbhUoe0BcKx9Ho
         mhPLGeBrkhK8PssiRkcwouZDP70fjg6j/EpgxrbGI5uzngV96jkqBhpiunRA/FG/ceVm
         wfZ32I3l/EeKJMoPN576ApbTylBJ3L2ML3kgXbXHb9lhYrmsMJRtejvFE08u8TDJM1X2
         ddgvYqyLr6oyFgILepy3WKqNf5UPIRyP0Mo4LsNUJMVUqzTn7MzpBtcqVGhIo9zJBejf
         zn/zpK2zpJL5akyQktzAEq9OwIcl6iffy6Z7QZCQRzjXF1f52XfSZ/BkYF9FdB4+acWh
         fb+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772172235; x=1772777035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xle5YbXN6KwFDRvCphlTjI+Jhqul262ibdvj3JnVvLE=;
        b=MLJuY3LSMlt3wVkGoAZkgDCqF+oX288fuR2G+g4t4qNltoN4U2z8W9Vi2lRfzfl+7o
         uVrpjZKWBPYtPob6vEqu7TTlpG6H6hcwaLGwQTp9bBI9wRwakszbozoQ3k+BGlZDwK0g
         q0YaBhOLDEg5OuBapLEAQgCbJLMBPaU0+EW1OYg0u5HXfTnP9Zlw32hJ2wx0dgjT1K6v
         YgZxvPihIAW7ETYp9E9stxTJ7QDHrs978njhVymYpDyl8meDf6xx6u55xoBJPy0jYj8T
         lGHDRcb+5SZr2zqxckRPsCwRfvwaQpi8AknYPSzsZEBZJRu4Y4NyYByeYpNkOHNjONyi
         witg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172235; x=1772777035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xle5YbXN6KwFDRvCphlTjI+Jhqul262ibdvj3JnVvLE=;
        b=k7kA7fpuH5yQw0aYfCdj5Jb4NW/ntO1w3jTV3SBnmSgPLUrJvaI///ZbfguqVwbp7f
         XW9xOOZCIRRZa7KFHh0xLBjb3WJCL4LgL2yvWLk2T8/CYT+R7yq33ZmOViEXliVehBpu
         mHc71lnNGfh38WN61AXHh9GUKFrI8w3kdixwl8nEzAW6/4vNwIgTwQ6GwK8jiX1AtuKV
         t+1VuuKJidDAyN7VWra+fYU3MlA+W4g/fuoswM/AhpbLq0niYPwYsstdVy6z2u9Q57C6
         zF23bmVATZstIV9RgrV6ElMYsFN/Vl4J9IsULBniHt5VK5YeqIOF3BH4f5yb79vGpDNE
         pX8w==
X-Forwarded-Encrypted: i=1; AJvYcCWA4CGqcPFUm1GazLsjLxmfTaGHATEweeeEvVxql25rWMh/PjUxuiZvhfkKTp936NnNQAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojwY7xCY5UCdMol099Yi2zqemztZymlWRydVjjz+dnmL1fKPC
	y7eqP94On0yrwgUH29kLyDWTWIPFvhiKForgwDCUdqCp/j04u3LXsrkdS0uvUMVaCAd0C5wffZU
	E4CzMhhcjkE1VkiApAFvkGviRlI/MJACDk0bSq3KmwhLTp6kOFNbbjsfggzOqY2upBnRqH6SqHn
	YcSD2N4HmhzDsBoMFRePSwSFr3CU7L
X-Gm-Gg: ATEYQzzGuCKte5qGUAZL/iganjGgE6QcHSwmKpxDtjOljw1xUyxxBwLzAO4gfelm/Bm
	zo+Rpl1wFaNXXsei/FgUeHHACfQ1e36YX4a583jpt79B/Q1lQ/TxboZPaU7NY+WZyvDFLyvAfyG
	yJ+9pG/OngEk6hLEO8KkdOJIjYvghL+BXJ/K8V6NAsiyRptZqtrKv3dCjJqVgeDjj/t1/6a7m9b
	EHUP1A=
X-Received: by 2002:a05:7301:1008:b0:2b7:fdb6:ccfe with SMTP id 5a478bee46e88-2bde1efb928mr871913eec.19.1772172234093;
        Thu, 26 Feb 2026 22:03:54 -0800 (PST)
X-Received: by 2002:a05:7301:1008:b0:2b7:fdb6:ccfe with SMTP id
 5a478bee46e88-2bde1efb928mr871892eec.19.1772172233542; Thu, 26 Feb 2026
 22:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119032424.10781-1-piliu@redhat.com> <20260226143628.7c6db69d@rotkaeppchen>
In-Reply-To: <20260226143628.7c6db69d@rotkaeppchen>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 27 Feb 2026 14:03:42 +0800
X-Gm-Features: AaiRm50HkXbMe-2Di-B7yH2Mu4n1COUPjaSX1wmFLDO_bYZeCTwE8vWLE0-IyWY
Message-ID: <CAF+s44QC+u8Lx91DmuDsE3AwAne0eouRKfFZ4CjWBCpE2W_Q5A@mail.gmail.com>
Subject: Re: [PATCHv6 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
To: Philipp Rudo <prudo@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, bpf@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

Thank you for taking the time to look into this.

On Thu, Feb 26, 2026 at 9:36=E2=80=AFPM Philipp Rudo <prudo@redhat.com> wro=
te:
>
> Hi Pingfan,
>
> please excuse my late reply. I've looked through the series and all in
> all it looks fine to me. I've got two comments/questions in addition to
> what the bpf-bot found. In general the findings from the bpf-bot look
> valid to me. But fixing them should be rather straight forward. Only
> for the first finding, where it "complains" that ctx->buf is NULL, I
> don't understand what it is wants to tell us.
>

A race condition exists: when bpf_buffer_parser() is called multiple
times on ctx, later calls overwrite the previous ctx->buf without
releasing it. While re-entrancy is uncommon in this design, it still
needs to be addressed.

> In my opinion the next step we should take is to implement an example
> bpf-prog for UKIs. I expect it to be much more complex compared to the
> zboot one. So having a example bpf-prog will show us if we run into any
> limitations with bpf or need to adjust the interfaces.
>

Yeah, it's a little challenge. The traditional kexec_file_load syscall
interface was tailored for the kernel boot protocol. However, with the
emergence of Zboot and UKI images, it fails to automatically
accommodate these new formats.

Now, with the introduction of decompose_kexec_kimage() to
kexec_file_load, the design takes a different approach. It decomposes
these complex modern images and then reassembles them into the kernel
boot protocol. Consequently, the fds parameter in kexec_file_load()
can have more flexible meanings, no longer limited to kernel or initrd
file descriptors.

I'm considering two alternative approaches. The first is to introduce
an fd array to pass the file descriptors for UKI and cmdline add-ons.
The second option is to reuse the current interface but reinterpret
the meaning of fds. The first approach requires not just an fd array
but also metadata describing the purpose of each file descriptor. In
contrast, the second option avoids this complexity.
In the second option, the first fd in kexec_file_load can be used to
ship the bpf parsers. the second fd can be used to ship a temporary
file, which holds UKI and all addons. Inside the kernel, the bpf
parser can extract the PE files embeded inside the temporary file,
verify their signature, decide their role and reassemble them. So all
details are kept inside the bpf parser without changing the kernel
API.

To implement this, the design in this series requires some
adjustments. Rather than embedding BPF parsers in PE-based formats
like Zboot or UKI, this approach improves the design by keeping the
kernel image unmodified.


What is your opinion?


Thanks,

Pingfan




> Thanks
> Philipp
>
> On Mon, 19 Jan 2026 11:24:11 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> > *** The history ***
> >
> > Nowadays, UEFI PE bootable images are becoming increasingly popular
> > among distributions. Currently, we have several kinds of image format
> > parsers in user space (kexec-tools). However, this approach breaks the
> > integrity protection of the images. To address this integrity protectio=
n
> > concern, several approaches have been proposed to resolve this issue,
> > but none of them have been accepted upstream yet.
> >
> > The summary of those approaches:
> >   -1. UEFI service emulator for UEFI stub
> >   -2. PE format parser in kernel
> >   -3. Signing the arm64/boot/Image
> >
> >
> > For the first approach, I tried a purgatory-style emulator [1], but it
> > encounters hardware scaling issues. For the second approach, both
> > zboot-format [2] and UKI-format [3] parsers were rejected due to
> > concerns that variant format parsers would bloat the kernel code.
> > Additionally, for example in arm64, both UKI and zboot format parsers
> > would need to be introduced and chained together to handle image
> > loading. For the third approach, I attempted [4], but since zboot or UK=
I
> > images already have signatures, upstream maintainers dislike the
> > additional signature on the Image. Moreover, for secure boot UKI, this
> > method cannot use signatures to protect the initramfs.
> >
> >
> > *** The approach in this series ***
> >
> > This series introduces an approach that allows image formats to be
> > parsed by BPF programs. As a result, the kexec kernel code can remain
> > relatively stable without introducing new parsers for different
> > architectures.  This approach introduces a dedicated '.bpf' section in
> > the PE file, which stores BPF bytecode. The integrity of all
> > components -- kernel, initramfs, cmdline, and even the BPF bytecode
> > itself is protected by the PE file's signature.  After signature
> > verification, the BPF bytecode is loaded and executed from within the
> > kernel using BPF lskel. Therefore, the bytecode itself is protected fro=
m
> > malicious attacks on the BPF loader in user space.
> >
> > When a .bpf section is extracted from the current image file, its
> > bytecode is attached to the kexec kernel function
> > kexec_image_parser_anchor(). After the bytecode parses the image, the
> > next-stage image is prepared, and the bytecode in the new .bpf section
> > can be attached to kexec_image_parser_anchor(). In this way, nested
> > image format issues (e.g., zboot image within UKI on arm64) can be
> > resolved.  (Theoretically not yet tested.)
> >
> >
> > *** Thanks ***
> > I would like to thank Philipp Rudo, whose insights inspired this
> > approach and who dedicated significant time to evaluating its
> > practicality. I am also grateful to Viktor Malik for his guidance on
> > using BPF light skeleton to prevent malicious attacks from user space.
> >
> >
> > *** Test approach ***
> > -1. compile kernel
> > -2. get the zboot image with bpf-prog by 'make -C tools/kexec zboot'
> > -3. compile kexec-tools from https://github.com/pfliu/kexec-tools/tree/=
pe_bpf
> >
> > The rest test process is the common convention to use kexec.
> >
> >
> > [1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.c=
om/T/
> > [2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gm=
ail.com/
> > [3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.=
cc/
> > [4]: https://lore.kernel.org/linux-efi/20230921133703.39042-1-kernelfan=
s@gmail.com/
> >
> >
> > *** Changes ***
> > v5 -> v6
> >   - Re-organize the layers in kexec_file_load into two layers: format-p=
arsing and kernel boot protocol handling.
> >   - Simplify the bpf kfunc interface.
> >   - rebased onto Linux 6.19-rc2
> >
> > v4 -> v5
> >   - rebased onto Linux 6.17-rc2
> >   - [1/12], use a separate CONFIG_KEEP_COMPRESSOR to decide the section
> >     of decompressor method
> >   - [10/12], add Catalin's acked-by (Thanks Catalin!)
> >
> > v3 -> v4
> >   - Use dynamic allocator in decompression ([4/12])
> >   - Fix issue caused by Identical Code Folding ([5/12])
> >   - Integrate the image generator tool in the kernel tree ([11,12/12])
> >   - Address the issue according to Philipp's comments in v3 reviewing.
> >     Thanks Philipp!
> >
> > RFCv2 -> v3
> >   - move the introduced bpf kfuncs to kernel/bpf/* and mark them sleepa=
ble
> >   - use listener and publisher model to implement bpf_copy_to_kernel()
> >   - keep each introduced kfunc under the control of memcg
> >
> > RFCv1 -> RFCv2
> >   - Use bpf kfunc instead of helper
> >   - Use C source code to generate the light skeleton file
> >
> >
> > ---
> > Pingfan Liu (13):
> >   bpf: Introduce kfuncs to parser buffer content
> >   kexec_file: Move signature validation ahead
> >   kexec_file: Introduce routines to parse PE file
> >   kexec_file: Use bpf-prog to decompose image
> >   lib/decompress: Keep decompressor when CONFIG_KEEP_DECOMPRESSOR
> >   kexec_file: Implement decompress method for parser
> >   kexec_file: Implement copy method for parser
> >   kexec_file: Introduce a bpf-prog lskel to parse PE file
> >   kexec_file: Factor out routine to find a symbol in ELF
> >   kexec_file: Integrate bpf light skeleton to load image with bpf-prog
> >   arm64/kexec: Select KEXEC_BPF to support UEFI-style kernel image
> >   tools/kexec: Introduce a bpf-prog to parse zboot image format
> >   tools/kexec: Add a zboot image building tool
> >
> >  arch/arm64/Kconfig                           |   1 +
> >  include/linux/bpf.h                          |  19 +
> >  include/linux/decompress/mm.h                |   8 +
> >  kernel/Kconfig.kexec                         |   8 +
> >  kernel/Makefile                              |   2 +
> >  kernel/bpf/Makefile                          |   3 +
> >  kernel/bpf/bpf_buffer_parser.c               | 170 +++++++
> >  kernel/kexec_bpf/Makefile                    |  70 +++
> >  kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  12 +
> >  kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 130 ++++++
> >  kernel/kexec_bpf/template.c                  |  68 +++
> >  kernel/kexec_bpf_loader.c                    | 439 +++++++++++++++++++
> >  kernel/kexec_file.c                          | 106 +++--
> >  kernel/kexec_internal.h                      |   5 +
> >  kernel/kexec_uefi_app.c                      |  81 ++++
> >  lib/Kconfig                                  |   6 +
> >  lib/decompress.c                             |   6 +-
> >  tools/kexec/Makefile                         |  91 ++++
> >  tools/kexec/pe.h                             | 177 ++++++++
> >  tools/kexec/template.c                       |  68 +++
> >  tools/kexec/zboot_image_builder.c            | 278 ++++++++++++
> >  tools/kexec/zboot_parser_bpf.c               | 114 +++++
> >  22 files changed, 1813 insertions(+), 49 deletions(-)
> >  create mode 100644 kernel/bpf/bpf_buffer_parser.c
> >  create mode 100644 kernel/kexec_bpf/Makefile
> >  create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
> >  create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
> >  create mode 100644 kernel/kexec_bpf/template.c
> >  create mode 100644 kernel/kexec_bpf_loader.c
> >  create mode 100644 kernel/kexec_uefi_app.c
> >  create mode 100644 tools/kexec/Makefile
> >  create mode 100644 tools/kexec/pe.h
> >  create mode 100644 tools/kexec/template.c
> >  create mode 100644 tools/kexec/zboot_image_builder.c
> >  create mode 100644 tools/kexec/zboot_parser_bpf.c
> >
>

