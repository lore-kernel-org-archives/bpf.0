Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9A2AEEB;
	Fri,  2 Oct 2026 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901775; cv=none; b=UXuoHp+5TNDoAka4VpGMXx96G427jZWStUGGsLkolhBSRo6ZBBhS5ejydjX71DSKP5rzBFuQpmH/IV5/RGVUaLc9YVTolyPxvvLEWiRKEMITVUjQNGhvGIA4vHpsCD1/EdnnbnY9yoFF7tN7UqBA9FXzkpcHjY8r/sZVDOpd1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901775; c=relaxed/simple;
	bh=YbMsRWXldzYM02I8oqDcFQLZD9fdt2zozI94YuxxZaM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=twSFWcjvCuSEaQxF0aYCmNWLc10OMu/tuFvE7dl2P9szRVonzBv2TbCuuROxrqxB9rnq/gdGckWbOGlz+giakxemQbledAAwczStFdsGszjsXdNk2Kz8jmA6g2S7GHE4HJ9jqTXN4D84RlH1s9ja/4w5wa3Mwpyqra8wxuCCdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGFgb3H5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGFgb3H5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A421F000FF;
	Fri,  2 Oct 2026 00:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901773;
	bh=QOzCHuJrRGWSsLn75AFrdWKS3cZSukBLofvP0LWEsAY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TGFgb3H5wYmgmq41GuV01uqNSUMtaynGOOn+///d+VidJWAJF8sGnebLdTAnVRNAw
	 /ROvXN+E089U5W+rXa6rGyKJ5K0vNaJkbtU6Qdu/cTCUHZLTprF91lQGeJcyG2OIn7
	 KbYSpRLt3j44BXXMjqKk7h7sMklILHhtQgDZkGToVfgyuVAV9sJWE3n+bQriTpDXHz
	 oFNpWjnj0R4hXuKOmegzdwfT0Vxl6RQNGw75L2FkvuWiRxfmTPs4bVUxfBWX0gF4FC
	 EkRoo5q32qvu1JM53ouFmfHO1OkLz8eq9zamULip60DHLEoqOxZlWPkTfHuMZX7LBT
	 sDHRD0znSswJg==
Content-Type: multipart/mixed; boundary="===============4958834672342477088=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <462c21076d261e56293cab2b423d4ed56cb36dda5c1a47c76182df07c290af70@mail.kernel.org>
In-Reply-To: <20261001152042.124445-8-gmonaco@redhat.com>
References: <20261001152042.124445-8-gmonaco@redhat.com>
Subject: Re: [PATCH v2 07/15] tools/rv: Implement BPF monitor discovery and listing
From: bot+bpf-ci@kernel.org
To: gmonaco@redhat.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,rostedt@goodmis.org,gmonaco@redhat.com
Cc: alexei.starovoitov@gmail.com,namcao@linutronix.de,wen.yang@linux.dev,tobias.schaffner@siemens.com,vmalik@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 00:42:53 +0000 (UTC)

--===============4958834672342477088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/rv: Implement BPF monitor discovery and listing

TL;DR:
- "make static" may now fail to link libbpf (missing -lelf/-lz) now that BPF
  is on by default
- Changelog lists fewer search paths than the code scans, including a cwd
  fallback

>     tools/rv: Implement BPF monitor discovery and listing
>
>     Implement the BPF monitor listing functionality that scans for compiled
>     BPF monitor object files and displays them in the monitor list.
>
>     If enabled, running rv list shows in-kernel and BPF monitors found in
>     /usr/share/rv/bpf_monitors/ or in ./bpf_monitors/ relative to the RV
>     binary's location (used during development).
>
>     Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

The commit message names /usr/share/rv/bpf_monitors/ and ./bpf_monitors/
relative to the rv binary.  Is that the complete search list?

bpf_list_monitors() scans every entry of bpf_base_paths[] with /bpf_monitors
appended:

static char bpf_base_paths[][MAX_PATH] = {
	".",
	"/etc/rv",
	"/usr/local/share/rv",
	"/usr/share/rv",
	"", /* Marker */
};

so /etc/rv/bpf_monitors and /usr/local/share/rv/bpf_monitors are searched
as well.

Entry 0 is replaced with the binary's directory only when
readlink("/proc/self/exe") succeeds in bpf_fill_base_paths().  Otherwise it
stays ".", and the current working directory's bpf_monitors is scanned
instead.

All of the directories are scanned, not one or the other, so a monitor
present in more than one of them is listed more than once.

Should the changelog describe the actual search list and the working
directory fallback, or should the list be trimmed to what is documented?
Is /etc/rv an appropriate place to look for BPF object files?

> diff --git a/tools/verification/rv/Makefile.config b/tools/verification/rv/Makefile.config
> index 066302230eb2..0600170ac217 100644
> --- a/tools/verification/rv/Makefile.config
> +++ b/tools/verification/rv/Makefile.config

[ ... ]

> @@ -43,6 +43,29 @@ else
>    $(info libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
>  endif
>  
> +ifndef BUILD_BPF
> +  # BPF monitors are optional but enabled by default
> +  BUILD_BPF := 1
> +endif
> +
> +ifeq ($(BUILD_BPF),0)
> +  $(info BPF monitor support disabled, building without BPF monitor support.)
> +endif
> +
> +$(call feature_check,libbpf)
> +ifeq ($(feature-libbpf), 1)
> +  $(call detected,CONFIG_LIBBPF)
> +else
> +  $(info libbpf is missing, building without BPF monitor support.)
> +  $(info Please install libbpf-dev/libbpf-devel)
> +  BUILD_BPF := 0
> +endif
> +
> +ifeq ($(BUILD_BPF),1)
> +  CFLAGS += -DHAVE_LIBBPF
> +  $(call lib_setup,bpf)
> +endif
> +

Can this break "make static" on systems where it worked before this patch?

BPF support is now on by default whenever the libbpf feature test passes,
and lib_setup only adds the output of pkg-config --libs-only-l libbpf, which
is just -lbpf.  libbpf.pc declares:

Requires.private: libelf zlib

and pkg-config only reports those with --static.  The existing static target
in tools/verification/rv/Makefile links with -static and $(EXTLIBS):

static: $(RV_IN)
	$(eval LDFLAGS += -static)
	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RV)-static $(RV_IN) $(EXTLIBS)

Would that link libbpf.a without -lelf and -lz and fail with unresolved
libelf and zlib symbols, so that users now need BUILD_BPF=0 to get a static
build?

Could pkg-config be called with --static for the static target, the private
dependencies be added, or BPF support be disabled for static builds?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36944413541
--===============4958834672342477088==--
