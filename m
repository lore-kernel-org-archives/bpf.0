Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6131F30AD
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774143880; cv=none; b=qFv4jH21tm7FrN6Qh3fsjCrmlrUC8tZp3KCbkZiyJctXdyDxkbXVudk2ANrdQHVbpbDZZ4BBImXlFmQwnCmtZF7mLuu135f5w1c123oj3DnSQUiAq26zzS9O0nyWadrFq9eJwSZ9YyuUrDdq2qNAzrzuIWZA0OFUHjYlB8KR7Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774143880; c=relaxed/simple;
	bh=XsSYI89rUMikfIU38WCflwY6jMBv+3Fj9LlzuWjcOxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cRe2oZXQ6PHLUW4zmCdGIzXVisNv+itZK4vFYmjpBMyt3rYT+hG4vDrJl7j3DiMoj9bMMq/hikrelnnglusYNXIHKdFgtCK0Un9I9Bphm+OWWS3S4F+IvOKZg1jnNZPIJMethMT79N6N5bM2HZFqBuwWEEAJrENfw0L1Nb4R8gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSaK5eeC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSaK5eeC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774143877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AqEEL25LD51u+oJXMo+RBoLHenSW9n6bAMMAPGybk7E=;
	b=RSaK5eeCeueRS7iOsIxCh8gnTrxVI2tzmQJY8Gw5jQCuQH6IkJLzlFdbly5K2MOE16YYQ0
	tLiDH6C78CGr428PB35tA3Jtb9dbM+xo3u023ylBvM0V+VDVhRKAh6GzOAb1Q02I0UQJ7D
	rGc/tAwknM2TUIdGBMsSZCjsaTK/uuk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-BKqg7uL7MCytRdzsKJ4GAA-1; Sat,
 21 Mar 2026 21:44:35 -0400
X-MC-Unique: BKqg7uL7MCytRdzsKJ4GAA-1
X-Mimecast-MFC-AGG-ID: BKqg7uL7MCytRdzsKJ4GAA_1774143873
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35CEC180044D;
	Sun, 22 Mar 2026 01:44:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE2BD300019F;
	Sun, 22 Mar 2026 01:44:18 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: 
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE format boot image
Date: Sun, 22 Mar 2026 09:43:49 +0800
Message-ID: <20260322014402.8815-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

*** The history ***

Nowadays, UEFI PE bootable images are becoming increasingly popular
among distributions. Currently, we have several kinds of image format
parsers in user space (kexec-tools). However, this approach breaks the
integrity protection of the images. To address this integrity protection
concern, several approaches have been proposed to resolve this issue,
but none of them have been accepted upstream yet.

The summary of those approaches:
  -1. UEFI service emulator for UEFI stub
  -2. PE format parser in kernel
  -3. Signing the arm64/boot/Image


For the first approach, I tried a purgatory-style emulator [1], but it
encounters hardware scaling issues. For the second approach, both
zboot-format [2] and UKI-format [3] parsers were rejected due to
concerns that variant format parsers would bloat the kernel code.
Additionally, for example in arm64, both UKI and zboot format parsers
would need to be introduced and chained together to handle image
loading. For the third approach, I attempted [4], but since zboot or UKI
images already have signatures, upstream maintainers dislike the
additional signature on the Image. Moreover, for secure boot UKI, this
method cannot use signatures to protect the initramfs.


*** The approach in this series ***

This series introduces an approach that allows image formats to be
parsed by BPF programs. Through BPF, two main functions, collecting
kernel boot protocol data and decompression, are exposed to BPF programs
via the commands KEXEC_BPF_CMD_DECOMPRESS and KEXEC_BPF_CMD_COPY.
As a result, the kexec kernel code can remain relatively stable without
requiring new parsers for different architectures.

Beside above, this approach redesigns kexec_file_load(): kernel_fd is
used to pass the BPF parser, while initrd_fd can be used to carry
everything else, the kernel image, initrd, and cmdline data. So we can
avoid changing the kexe_file_load() protocol. 


The main purpose of this series is to provide format flexibility. This
is demonstrated by the patch 'tools/kexec: Introduce a bpf-prog to
handle zboot image', where the BPF program works in conjunction with a
private format defined in 'tools/kexec: Introduce a tool to build zboot
envelope'.


*** Outlook for the security support (the next step) ***

The remaining issue in this series is the security support.
The isolated bpf-prog can be signed as what is done on kernel module,
and verified as the trusted root later.
Each signed PE can be asked to be verified by the trusted bpf-prog.

For IMA, an out-most bpf-parser will be introduced to read each file by
kernel_read_file_from_path(..., READING_KEXEC_IMAGE).


*** Thanks ***
I would like to thank Philipp Rudo, whose insights inspired this
approach and who dedicated significant time to evaluating its
practicality. I am also grateful to Viktor Malik for his guidance on
using BPF light skeleton to prevent malicious attacks from user space.


*** Test approach ***
-1. compile kexec-tools from https://github.com/pfliu/kexec-tools/tree/bpf_loader
-2. compile kernel
-3. For UKI, get the UKI parser bpf-prog by 'make -C tools/kexec uki',
    there will be uki.bpf.
    Load it by:
        kexec -s -l uki.bpf image.uki

    For zboot, get the zboot parser by 'make -C tools/kexec zboot'
    create the zboot envelop (packing vmlinuz.efi, initrd, cmdline) by:
        tools/kexec/build_zboot_envelop vmlinuz.efi initrd "cmdline"
    The default envelop image is named "zboot_image.elf"
    Load it by:
        kexec -s -l zboot.bpf zboot_image.elf


[1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/
[2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gmail.com/
[3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
[4]: https://lore.kernel.org/linux-efi/20230921133703.39042-1-kernelfans@gmail.com/


*** Changes ***
v6 -> v7:
  - Redesign the kexec_file_load interface to prevent BPF section injection
    into UKI or zboot images. The kernel_fd now carries the BPF parser,
    while initrd_fd carries the UKI image.
  - Introduce a UKI image parser.
  - Enhance the zboot parser to support both UKI and direct zboot images.
  - Fix the bug reported by bot+bpf-ci


v5 -> v6
  - Re-organize the layers in kexec_file_load into two layers: format-parsing and kernel boot protocol handling.
  - Simplify the bpf kfunc interface.
  - rebased onto Linux 6.19-rc2

v4 -> v5
  - rebased onto Linux 6.17-rc2
  - [1/12], use a separate CONFIG_KEEP_COMPRESSOR to decide the section
    of decompressor method
  - [10/12], add Catalin's acked-by (Thanks Catalin!)

v3 -> v4
  - Use dynamic allocator in decompression ([4/12])
  - Fix issue caused by Identical Code Folding ([5/12])
  - Integrate the image generator tool in the kernel tree ([11,12/12])
  - Address the issue according to Philipp's comments in v3 reviewing.
    Thanks Philipp!

RFCv2 -> v3
  - move the introduced bpf kfuncs to kernel/bpf/* and mark them sleepable
  - use listener and publisher model to implement bpf_copy_to_kernel()
  - keep each introduced kfunc under the control of memcg

RFCv1 -> RFCv2
  - Use bpf kfunc instead of helper
  - Use C source code to generate the light skeleton file


Pingfan Liu (13):
  bpf: Introduce kfuncs to parser buffer content
  kexec_file: Use bpf-prog to decompose image
  lib/decompress: Keep decompressor when CONFIG_KEEP_DECOMPRESSOR
  kexec_file: Implement decompress method for parser
  kexec_file: Implement copy method for parser
  kexec_file: Chain the stages into a pipeline
  kexec_file: Introduce a bpf-prog lskel to run a format parser
  kexec_file: Factor out routine to find a symbol in ELF
  kexec_file: Integrate bpf light skeleton to load image with bpf-prog
  arm64/kexec: Select KEXEC_BPF to support UEFI-style kernel image
  tools/kexec: Introduce a bpf-prog to handle zboot image
  tools/kexec: Introduce a bpf-prog to handle UKI image
  tools/kexec: Introduce a tool to build zboot envelop

 arch/arm64/Kconfig                           |   1 +
 include/linux/bpf.h                          |  20 +
 include/linux/decompress/mm.h                |   8 +
 kernel/Kconfig.kexec                         |   8 +
 kernel/Makefile                              |   2 +
 kernel/bpf/Makefile                          |   3 +
 kernel/bpf/bpf_buffer_parser.c               | 186 ++++
 kernel/kexec_bpf/Makefile                    |  70 ++
 kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  12 +
 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 130 +++
 kernel/kexec_bpf/template.c                  |  72 ++
 kernel/kexec_bpf_loader.c                    | 873 +++++++++++++++++++
 kernel/kexec_file.c                          | 104 ++-
 kernel/kexec_internal.h                      |   5 +
 lib/Kconfig                                  |   6 +
 lib/decompress.c                             |   6 +-
 tools/kexec/Makefile                         | 203 +++++
 tools/kexec/build_zboot_envelop.c            | 362 ++++++++
 tools/kexec/template.c                       |  72 ++
 tools/kexec/uki_parser_bpf.c                 | 235 +++++
 tools/kexec/zboot_envelop.h                  |   7 +
 tools/kexec/zboot_parser_bpf.c               | 348 ++++++++
 22 files changed, 2719 insertions(+), 14 deletions(-)
 create mode 100644 kernel/bpf/bpf_buffer_parser.c
 create mode 100644 kernel/kexec_bpf/Makefile
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
 create mode 100644 kernel/kexec_bpf/template.c
 create mode 100644 kernel/kexec_bpf_loader.c
 create mode 100644 tools/kexec/Makefile
 create mode 100644 tools/kexec/build_zboot_envelop.c
 create mode 100644 tools/kexec/template.c
 create mode 100644 tools/kexec/uki_parser_bpf.c
 create mode 100644 tools/kexec/zboot_envelop.h
 create mode 100644 tools/kexec/zboot_parser_bpf.c

-- 
2.49.0

