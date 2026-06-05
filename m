Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F6840E8E6
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666807; cv=pass; b=cc3o/8yLxtflxJo78DI4tDNdZWew53uyEJ0C6z2s4zthGTmO7C+Lyi/PYxG954mfexNoKwK3nmHLGPsut7miGu/LUHfZS3qwg5Vkb7Q44Xb9iJVLU6zKbkTiq9BAS+B5+LByIxNr7tNVlgzdwv6WQVsvOmHgCg5Xhp6nY25ueSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666807; c=relaxed/simple;
	bh=NXVv5G8ZjXXX91vDQZ4zsrw9ziOnzBogrKzoH3bFbYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzqHMcgYCjRDibt7ZCfhgeRF6dsIs1pMvic8yEKqhYb4PCy8GClR7BuFM4CQ99Y2wMb3fEhfWrq/aY/pAHTAcFB6CKGbIDz5rjpQ+ztUriTH1mQi2y0iJJtuG7pB/eY9nwMnZ7aJPNIWbjZl9PUzfEK1Y+dhietksMZf0GDOE5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaxVT5vY; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaxVT5vY"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ee6d32402so1076182f8f.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 06:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780666804; cv=none;
        d=google.com; s=arc-20240605;
        b=BcMQ1gQFymr8jusfOqv9/SnecH5ALV1JsPEMMXh7F9dG6ZNWJd6h4tXulSgOvyDej7
         taax7MryVVFovnDXa+1eXVqGpUd9+7xaaHA1sT54MG6ro+E9GcvQPMbVZqjnBV8cMs6z
         Yf5ytWqxWyMzsM04MdbrkADJdutT5d9FxkPV3OxuKGCN7Q4FSmU4TTc615hUTauKCJis
         CpPC16LbUYPNJpa8olEDhXZlKtgLbctfdIN+VtlR1DLq/VrerDuNbevWze8I2Rar2zu4
         zyh1jqPm8nhfNwbkOE0jHNj13Ow0Ik1PLcm4zBnYSxbv+byG8SvnKuaA9ArCh7w/oQfG
         69sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LiVg/aBuWVrMguSpz5n5CE35KtBF30v3XL/eAKvboRE=;
        fh=qjBd7/Z4lnlTnUT1n8vgcQ1JRfnWWFOo0Q+MERyuh3Y=;
        b=MjhBq7vINqjoilfAFwxQsNWEJsvLYHc4TdmLeVuY9Xdx/ZLzA75qV3bq0CTJn1U1In
         FkpR31bz+AbT/UuEmlOEgKvnKfhRnaSFXjRSLlzPGUTiJNJ5bZHoGv8U49bEZefuLZQ8
         jjU58hxNh+0TnHAy8sRKEsXRYVzwByeya5PZmeZHEu3BrJ2iVGi2Hk5r0p9wtrmSafxh
         teFninrDKH06G4GZzjdvUfT/9LcnAUtpKJHByFe9csPvNG3QL+BHO559d6Z97ySR9Q4w
         eLxsVPPuN7X9MrQGzznbTZtHQZYmUm6mZj5S01JU8lBzCuLWUUNo7UbmjaCwWpA5yQ0m
         ZKjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780666804; x=1781271604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiVg/aBuWVrMguSpz5n5CE35KtBF30v3XL/eAKvboRE=;
        b=ZaxVT5vY1tMfOmUI6qcaIr6NAFWvpyxuBJpVToqnY4yrMKXt1ar5o8kg4xN4XAZ75R
         8VtiXKteMWAZzWQFYP1/MunLtf2uf9hvEEy9mxMhmcwNYx4ZOM8SeMt+50SQcdQnj0mW
         +D5H+/3HQP7sXQN/bOMfjei/sgqstbxTrUmrB7b+AfFuiXfeR3UnBQFk3i0wzskkXTQK
         McHSs38ccf7iLIjKFzk8UkKAH0S9qDDZhH4jZ9vtYdr5p/ZkpZLbiGOWDZu+pk+BQ2qt
         yGmH8wrkAbNXf19N4A/OhpxzqF9DcuV/m58vqj0YazM3x+xawp6PSBK7K1oE+O0UgLAF
         98fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780666804; x=1781271604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LiVg/aBuWVrMguSpz5n5CE35KtBF30v3XL/eAKvboRE=;
        b=o1uPbNeXUHlf51El+p2HCZ4dCsfAVtTwwhGU4TeSfn8fN6+DpLo2LsKM4dnNOnkix3
         +4nTWZaZhUdJWhjN4itX61l3lGweaiGHCcTm6XRoU9G7x0D64bwW+kfYXNtTvmwFDg4o
         bY+wFrpjdRgsEWzVW8F9EaW0k7avv9H1EVF4QWds41RA/Wm0ajCmW2m5ZOoNHhP2B1hR
         ey++2K3NUCdwwoR40zE6ifECbyVZjse2/mwWzUTWpsQ92x9UdwX2GuZrh4KyYgxdKHQl
         W1/Gvx5qS2lLuBrKOtgICz+L4JrJRznd61cpNvX8UOhyB62QLC5Zjz+QjSeg27i0WNJd
         urGw==
X-Forwarded-Encrypted: i=1; AFNElJ/6CxiXvw6NZG2IlyQluxMUTKwSQj7jF015EIl1O0S7mzUtRs4EHgY9PfA9AfbrpvBul+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLEJVppAPPGS7oSTArhuU2vdaIdRoR0VVBxX81j62cuYvxTym
	yp3A8HofFxtC+FUDsCt0Sn0BqSkA+subnUQu0aZp2gmxjmcbUTUh0MKoBkMVyuBxshlFcw51qiL
	MHDapKtRIbAJDHGETUdGLYIZJQaOrkXs=
X-Gm-Gg: Acq92OHB5TxIJicI9nc9Q4AKJtIrN5niWAenLmE7Y2T1PCubmbmmwCHvfSEaVhmCVkt
	ZEGCRBM2LMQo47sWLmDKuKxbRXL232RM/U81jCMiGiqtFaVVGlNBXRaGuHxOwyTBPUd9UdkoZnp
	x15KKD6QVnAS/O9zxr+YkTt1G6+k/fCFDGlu+VFCZFXE5RJx1Uu0ZQSPNaF4hex6wo80ptLwT8K
	ZO76TeDK4KODmv5OSjBAZQ7dpUJTXGqexkPPzkRZITnw3P5i21NH2rNXziZoj16/IcxmRXtTabC
	imKEPaUYaf+1qjPr89mrksXdGQnuzX9ffZlLK7gjH4QuaSczjxo7A1WfXvocyEXNhIQXdnIiTAG
	c4hA0v5aI2hb6yRURCbgjR2ag6jPTo1TH/Q==
X-Received: by 2002:adf:ea12:0:b0:43f:e2b7:7160 with SMTP id
 ffacd0b85a97d-460304f01bfmr4581992f8f.4.1780666803193; Fri, 05 Jun 2026
 06:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-remove-lirc-test-v1-1-ee3f1ea5f3ae@bootlin.com>
In-Reply-To: <20260605-remove-lirc-test-v1-1-ee3f1ea5f3ae@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Jun 2026 06:39:51 -0700
X-Gm-Features: AVVi8CfWbJgoMqITB3-_uk0rcaG6K6Qc86NA0qVhYhO-cwK9SNn6D_CUqlOMWqI
Message-ID: <CAADnVQJWBN2wohM8PM4rNGqtgGWQH__sgjrUv7h8SmWE7Px0FA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/selftests: remove lirc test
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, Sean Young <sean@mess.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Alexis Lothore <alexis.lothore@bootlin.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 12:58=E2=80=AFAM Bastien Curutchet (eBPF Foundation)
<bastien.curutchet@bootlin.com> wrote:
>
> test_lirc_mode.sh fails with the following when run from the vmtest VM:
> root@(none):/root/bpf# ./test_lirc_mode2.sh
> Failed to read decoded IR: Resource temporarily unavailable
> FAIL: lirc_mode2
>
> As part of the ongoing effort to get rid of any standalone test, this
> script should either be fixed and converted to test_progs or removed.
>
> Remove it.

cc Sean

> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@boo=
tlin.com>
> ---
> Hi all,
>
> I went back up to v6.13 without finding a working commit. Maybe
> something's wrong with my setup but comments inside
> test_lirc_mode2_user.c say that three kernel configurations are needed
> to have the test working and I ensured they were indeed enabled (with
> s/BPF_RAWIR_EVENT/BPF_LIRC_MODE2).
>
> If someone disagrees with this removal please speak up and I'll
> investigate this further.
>
> Best regards,
> Bastien
> ---
>  tools/testing/selftests/bpf/.gitignore             |   1 -
>  tools/testing/selftests/bpf/Makefile               |   3 -
>  .../selftests/bpf/progs/test_lirc_mode2_kern.c     |  26 ---
>  tools/testing/selftests/bpf/test_lirc_mode2.sh     |  41 -----
>  tools/testing/selftests/bpf/test_lirc_mode2_user.c | 177 ---------------=
------
>  5 files changed, 248 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index 986a6389186ba..b815bf0d88774 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -17,7 +17,6 @@ test_verifier_log
>  feature
>  urandom_read
>  test_sockmap
> -test_lirc_mode2_user
>  flow_dissector_load
>  test_tcpnotify_user
>  test_libbpf
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index bc049620c7745..653c949fc854d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -117,7 +117,6 @@ TEST_FILES =3D xsk_prereqs.sh $(wildcard progs/btf_du=
mp_test_case_*.c)
>
>  # Order correspond to 'make run_tests' order
>  TEST_PROGS :=3D test_kmod.sh \
> -       test_lirc_mode2.sh \
>         test_bpftool_build.sh \
>         test_doc_build.sh \
>         test_xsk.sh \
> @@ -135,7 +134,6 @@ TEST_GEN_PROGS_EXTENDED =3D \
>         bench \
>         flow_dissector_load \
>         test_cpp \
> -       test_lirc_mode2_user \
>         veristat \
>         xdp_features \
>         xdp_hw_metadata \
> @@ -325,7 +323,6 @@ $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_H=
ELPERS)
>  $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TR=
ACE_HELPERS)
>  $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_tag: $(TESTING_HELPERS)
> -$(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
>  $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
>  $(OUTPUT)/test_maps: $(TESTING_HELPERS)
>  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELP=
ERS)
> diff --git a/tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c b/t=
ools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c
> deleted file mode 100644
> index 7a6620671a833..0000000000000
> --- a/tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// test ir decoder
> -//
> -// Copyright (C) 2018 Sean Young <sean@mess.org>
> -
> -#include <linux/bpf.h>
> -#include <linux/lirc.h>
> -#include <bpf/bpf_helpers.h>
> -
> -SEC("lirc_mode2")
> -int bpf_decoder(unsigned int *sample)
> -{
> -       if (LIRC_IS_PULSE(*sample)) {
> -               unsigned int duration =3D LIRC_VALUE(*sample);
> -
> -               if (duration & 0x10000)
> -                       bpf_rc_keydown(sample, 0x40, duration & 0xffff, 0=
);
> -               if (duration & 0x20000)
> -                       bpf_rc_pointer_rel(sample, (duration >> 8) & 0xff=
,
> -                                          duration & 0xff);
> -       }
> -
> -       return 0;
> -}
> -
> -char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/test_lirc_mode2.sh b/tools/testi=
ng/selftests/bpf/test_lirc_mode2.sh
> deleted file mode 100755
> index 5252b91f48a18..0000000000000
> --- a/tools/testing/selftests/bpf/test_lirc_mode2.sh
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -#!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=3D4
> -ret=3D$ksft_skip
> -
> -msg=3D"skip all tests:"
> -if [ $UID !=3D 0 ]; then
> -       echo $msg please run this as root >&2
> -       exit $ksft_skip
> -fi
> -
> -GREEN=3D'\033[0;92m'
> -RED=3D'\033[0;31m'
> -NC=3D'\033[0m' # No Color
> -
> -modprobe rc-loopback
> -
> -for i in /sys/class/rc/rc*
> -do
> -       if grep -q DRV_NAME=3Drc-loopback $i/uevent
> -       then
> -               LIRCDEV=3D$(grep DEVNAME=3D $i/lirc*/uevent | sed sQDEVNA=
ME=3DQ/dev/Q)
> -               INPUTDEV=3D$(grep DEVNAME=3D $i/input*/event*/uevent | se=
d sQDEVNAME=3DQ/dev/Q)
> -       fi
> -done
> -
> -if [ -n "$LIRCDEV" ];
> -then
> -       TYPE=3Dlirc_mode2
> -       ./test_lirc_mode2_user $LIRCDEV $INPUTDEV
> -       ret=3D$?
> -       if [ $ret -ne 0 ]; then
> -               echo -e ${RED}"FAIL: $TYPE"${NC}
> -       else
> -               echo -e ${GREEN}"PASS: $TYPE"${NC}
> -       fi
> -fi
> -
> -exit $ret
> diff --git a/tools/testing/selftests/bpf/test_lirc_mode2_user.c b/tools/t=
esting/selftests/bpf/test_lirc_mode2_user.c
> deleted file mode 100644
> index 88e4aeab21b7b..0000000000000
> --- a/tools/testing/selftests/bpf/test_lirc_mode2_user.c
> +++ /dev/null
> @@ -1,177 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// test ir decoder
> -//
> -// Copyright (C) 2018 Sean Young <sean@mess.org>
> -
> -// A lirc chardev is a device representing a consumer IR (cir) device wh=
ich
> -// can receive infrared signals from remote control and/or transmit IR.
> -//
> -// IR is sent as a series of pulses and space somewhat like morse code. =
The
> -// BPF program can decode this into scancodes so that rc-core can transl=
ate
> -// this into input key codes using the rc keymap.
> -//
> -// This test works by sending IR over rc-loopback, so the IR is processe=
d by
> -// BPF and then decoded into scancodes. The lirc chardev must be the one
> -// associated with rc-loopback, see the output of ir-keytable(1).
> -//
> -// The following CONFIG options must be enabled for the test to succeed:
> -// CONFIG_RC_CORE=3Dy
> -// CONFIG_BPF_RAWIR_EVENT=3Dy
> -// CONFIG_RC_LOOPBACK=3Dy
> -
> -// Steps:
> -// 1. Open the /dev/lircN device for rc-loopback (given on command line)
> -// 2. Attach bpf_lirc_mode2 program which decodes some IR.
> -// 3. Send some IR to the same IR device; since it is loopback, this wil=
l
> -//    end up in the bpf program
> -// 4. bpf program should decode IR and report keycode
> -// 5. We can read keycode from same /dev/lirc device
> -
> -#include <linux/bpf.h>
> -#include <linux/input.h>
> -#include <errno.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include <poll.h>
> -#include <sys/types.h>
> -#include <sys/ioctl.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -
> -#include "bpf_util.h"
> -#include <bpf/bpf.h>
> -#include <bpf/libbpf.h>
> -
> -#include "testing_helpers.h"
> -
> -int main(int argc, char **argv)
> -{
> -       struct bpf_object *obj;
> -       int ret, lircfd, progfd, inputfd;
> -       int testir1 =3D 0x1dead;
> -       int testir2 =3D 0x20101;
> -       u32 prog_ids[10], prog_flags[10], prog_cnt;
> -
> -       if (argc !=3D 3) {
> -               printf("Usage: %s /dev/lircN /dev/input/eventM\n", argv[0=
]);
> -               return 2;
> -       }
> -
> -       ret =3D bpf_prog_test_load("test_lirc_mode2_kern.bpf.o",
> -                                BPF_PROG_TYPE_LIRC_MODE2, &obj, &progfd)=
;
> -       if (ret) {
> -               printf("Failed to load bpf program\n");
> -               return 1;
> -       }
> -
> -       lircfd =3D open(argv[1], O_RDWR | O_NONBLOCK);
> -       if (lircfd =3D=3D -1) {
> -               printf("failed to open lirc device %s: %m\n", argv[1]);
> -               return 1;
> -       }
> -
> -       /* Let's try detach it before it was ever attached */
> -       ret =3D bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
> -       if (ret !=3D -ENOENT) {
> -               printf("bpf_prog_detach2 not attached should fail: %m\n")=
;
> -               return 1;
> -       }
> -
> -       inputfd =3D open(argv[2], O_RDONLY | O_NONBLOCK);
> -       if (inputfd =3D=3D -1) {
> -               printf("failed to open input device %s: %m\n", argv[1]);
> -               return 1;
> -       }
> -
> -       prog_cnt =3D 10;
> -       ret =3D bpf_prog_query(lircfd, BPF_LIRC_MODE2, 0, prog_flags, pro=
g_ids,
> -                            &prog_cnt);
> -       if (ret) {
> -               printf("Failed to query bpf programs on lirc device: %m\n=
");
> -               return 1;
> -       }
> -
> -       if (prog_cnt !=3D 0) {
> -               printf("Expected nothing to be attached\n");
> -               return 1;
> -       }
> -
> -       ret =3D bpf_prog_attach(progfd, lircfd, BPF_LIRC_MODE2, 0);
> -       if (ret) {
> -               printf("Failed to attach bpf to lirc device: %m\n");
> -               return 1;
> -       }
> -
> -       /* Write raw IR */
> -       ret =3D write(lircfd, &testir1, sizeof(testir1));
> -       if (ret !=3D sizeof(testir1)) {
> -               printf("Failed to send test IR message: %m\n");
> -               return 1;
> -       }
> -
> -       struct pollfd pfd =3D { .fd =3D inputfd, .events =3D POLLIN };
> -       struct input_event event;
> -
> -       for (;;) {
> -               poll(&pfd, 1, 100);
> -
> -               /* Read decoded IR */
> -               ret =3D read(inputfd, &event, sizeof(event));
> -               if (ret !=3D sizeof(event)) {
> -                       printf("Failed to read decoded IR: %m\n");
> -                       return 1;
> -               }
> -
> -               if (event.type =3D=3D EV_MSC && event.code =3D=3D MSC_SCA=
N &&
> -                   event.value =3D=3D 0xdead) {
> -                       break;
> -               }
> -       }
> -
> -       /* Write raw IR */
> -       ret =3D write(lircfd, &testir2, sizeof(testir2));
> -       if (ret !=3D sizeof(testir2)) {
> -               printf("Failed to send test IR message: %m\n");
> -               return 1;
> -       }
> -
> -       for (;;) {
> -               poll(&pfd, 1, 100);
> -
> -               /* Read decoded IR */
> -               ret =3D read(inputfd, &event, sizeof(event));
> -               if (ret !=3D sizeof(event)) {
> -                       printf("Failed to read decoded IR: %m\n");
> -                       return 1;
> -               }
> -
> -               if (event.type =3D=3D EV_REL && event.code =3D=3D REL_Y &=
&
> -                   event.value =3D=3D 1 ) {
> -                       break;
> -               }
> -       }
> -
> -       prog_cnt =3D 10;
> -       ret =3D bpf_prog_query(lircfd, BPF_LIRC_MODE2, 0, prog_flags, pro=
g_ids,
> -                            &prog_cnt);
> -       if (ret) {
> -               printf("Failed to query bpf programs on lirc device: %m\n=
");
> -               return 1;
> -       }
> -
> -       if (prog_cnt !=3D 1) {
> -               printf("Expected one program to be attached\n");
> -               return 1;
> -       }
> -
> -       /* Let's try detaching it now it is actually attached */
> -       ret =3D bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
> -       if (ret) {
> -               printf("bpf_prog_detach2: returned %m\n");
> -               return 1;
> -       }
> -
> -       return 0;
> -}
>
> ---
> base-commit: 73f574b0cd0ef87a25afdffe1d907b55f7fcc940
> change-id: 20260604-remove-lirc-test-fc8afa634f3a
>
> Best regards,
> --
> Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
>
