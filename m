Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699474;
	b=4jhNrXsZh4opqQal5VvxZOEoEyQiEKa6+c4DkGPw4wgD+D9wc31iw5amJ1xYvlPtsKMA
	 71gFbUm86/eC5K35I3R6biVE6HyUOMDSNLTjtkiZgqvdSZ9tGZ5kRB6c+yhrxiFmBc6We
	 VzM0llryO5iiNnnqIZFpTHbU6wCp63q1/5+P/es08yPMWOkE1ez0VmUzHMfoWgpngqcCu
	 y/gs9FGIeolEx2KTKyzfT+Kd6NlXg1vaEtUIRzrzFB+24OheCU/I6fwFAHboJw7SBCtEO
	 A+hpi7PrJbjOK6af/EP6MotA0zh6KMgMpXCxBaSmOQRKHgynQDonanOYfCAq68uWRCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699474;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/QkVDmkvFFY/Lm0obuPeRdKwHjB6HfMRJOTA+8/xFJo=;
	b=cZ4uoNRQmzYbevl1NIy7f+E7YYQ9m3/HHbKwa6OlS+B8jKr3UmTDu6gasMYSb3MwhYT5
	 dHq5BvBnL+S7zg0ot1DBH0DSuD8vAMzw9+9Ct1OWoGCL6Z6iWTsMmFcp7tcLjsXpH8MpI
	 tYhmCDRGzCMW49CyDkvQxNJnmbalKizebeHC68heMSRGudE3DdCWFz4r80Bh1qm7eNBl+
	 1i9U2GEnMAxwXgVjM7/+NCtW+ELy97qxgRh5XJDBjHkgCoSAIOJlwwogleI3R3GITLyIk
	 2/TQllp/gS74JfYrQm/gMeR6nXdldy0Zf4sWNvZYPeBpPT7w5yqg5nXfpecP5jqQmFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnRE1FN7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C711606A31C;
	Thu, 26 Nov 2026 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnRE1FN7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF4D1F01562;
	Thu, 26 Nov 2026 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699474;
	bh=/QkVDmkvFFY/Lm0obuPeRdKwHjB6HfMRJOTA+8/xFJo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dnRE1FN7Um+xCkkQ6Rb/D1ON8FQu28j62NS2R06JMj0ddHYIGmokZI653iVNcvLfL
	 PmilYasAb4Wv4IZWNtXUyMOMP64r/sxXaT6CKXtcySI2bkBKY3ONrWFLXmhaTsooHm
	 XbC2M1FmTPxJ+7HANsTfgwMSQBybB3QP+GPx+U+57/4fgINe37/CC5bMWmY/OZpiL0
	 5WXgxKj2cKMpvW9Sk0+igvI1C59yjwMr5AVfFc/8uxfaz8Uwx4utz5sgYiAahdoJEh
	 cGju0B9PJ2VWphWI2hGc4AUGPqgkHBgvpwKwNayiG+iQWKenStX16/M92zSEFYdjXv
	 Y2aKdzI2EC03g==
Message-ID: <sashiko-outbox-235595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/18] tools/rv: Add BPF monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261126130004.127155-14-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
 <20261126130004.127155-14-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:24:33 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] tools/rv: BPF monitor build fails when BTF source lacks
  CONFIG_RV types
- [Medium] tools/rv: BPF monitor build lacks -mcpu=3Dv3, likely()
  fallback, and O=3D support
- [Low] tools/rv: bpftool failure leaves empty bpf_monitors/vmlinux.h on
  disk
- [Low] tools/rv: missing da_reset() macro mappings in da_monitor_bpf.h
--

commit e722072977f9f930cda140d2eaa94a39a1ea1809
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Add BPF monitors

This commit adds two initial DA BPF monitors (tqueue and nohz), adapts
include/rv/da_monitor.h for BPF compilation via da_monitor_bpf.h, and
integrates BPF monitor building and installation into the tools/rv
Makefiles.

> diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makef=
ile
> index 0a8c7a656f7f3..4bac303246892 100644
> --- a/tools/verification/rv/Makefile
> +++ b/tools/verification/rv/Makefile
[ ... ]
> @@ -68,19 +72,50 @@ static: $(RV_IN)
>  	$(eval LDFLAGS +=3D -static)
>  	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RV)-static $(RV_IN) $(EXTLIBS)
> =20
> +BPF_DIR		:=3D bpf_monitors
> +BPF_SOURCES	:=3D $(wildcard $(BPF_DIR)/*.c)
> +BPF_OBJECTS	:=3D $(BPF_SOURCES:.c=3D.o)
> +VMLINUX_H	:=3D $(BPF_DIR)/vmlinux.h
> +
> +BPF_INCLUDES	:=3D -I$(srctree)/include/uapi
> +BPF_INCLUDES	+=3D -I$(srctree)/include
> +BPF_INCLUDES	+=3D -I$(BPF_DIR)
> +
> +BPF_CFLAGS	:=3D -g -O2 -target bpf -MMD -MP $(BPF_INCLUDES)
> +BPF_CFLAGS	+=3D -Wall -Wno-unused-function -Wno-missing-declarations

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v2 [1], does building the BPF
monitors fail on Clang older than 20, system libbpf headers older than
1.6, or out-of-tree O=3D builds?

Clang versions before 20 default to -mcpu=3Dv1, which rejects the 32-bit
cmpxchg and fetch-and-add instructions in da_event() and smp_mb() unless
-mcpu=3Dv3 is passed in BPF_CFLAGS.  Without -I$(srctree)/tools/lib or a
fallback definition in da_monitor_bpf.h, <bpf/bpf_helpers.h> resolves to
the system libbpf header, which lacks likely() and unlikely() prior to
libbpf 1.6.  Finally, BPF_DIR is not prefixed with $(OUTPUT), so O=3D
builds write artifacts into the source tree instead of $(OUTPUT), where
the rv binary looks for bpf_monitors.

> +
> +VMLINUX		:=3D ../../../vmlinux
> +VMLINUX_BTF	?=3D $(if $(wildcard $(VMLINUX)) , $(VMLINUX), /sys/kernel/b=
tf/vmlinux)
> +
> +$(VMLINUX_H): $(VMLINUX_BTF)
> +	$(QUIET_GEN)$(SYSTEM_BPFTOOL) btf dump file $< format c > $@

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v2 [2], does the default build
fail with incomplete type errors when $(VMLINUX_BTF) comes from a kernel
built without CONFIG_RV=3Dy?

BUILD_BPF_OBJS defaults to 1 whenever libbpf, clang, and bpftool are
installed, adding the bpf target to all.  Because include/linux/rv.h
guards struct rv_monitor, struct da_monitor, and union rv_task_monitor
under #ifdef CONFIG_RV, compiling the BPF monitors relies on vmlinux.h
providing those types from kernel BTF.  When the host or in-tree kernel
has CONFIG_RV disabled, those definitions are absent from vmlinux.h and
compiling da_monitor.h and da_monitor_bpf.h fails.

[Severity: Low]
As reported by bot+bpf-ci@kernel.org on v2 [3], if bpftool fails while
generating $(VMLINUX_H), does shell redirection leave an empty
bpf_monitors/vmlinux.h on disk?  Without .DELETE_ON_ERROR or writing via
a temporary file, subsequent make runs see an up-to-date header and fail
with compiler errors until make clean.

> diff --git a/tools/verification/rv/Makefile.rv b/tools/verification/rv/Ma=
kefile.rv
> index 2497fb96c83d2..418748bc3aa12 100644
> --- a/tools/verification/rv/Makefile.rv
> +++ b/tools/verification/rv/Makefile.rv
> @@ -33,12 +33,17 @@ INSTALL		:=3D install
>  MKDIR		:=3D mkdir
>  STRIP		:=3D strip
>  BINDIR		:=3D /usr/bin
> +BPF_MON_DIR	:=3D /usr/share/rv/bpf_monitors
> =20
>  .PHONY: install
>  install: doc_install
>  	$(Q)$(MKDIR) -p $(DESTDIR)$(BINDIR)
>  	$(call QUIET_INSTALL,rv)$(INSTALL) $(OUTPUT)rv -m 755 $(DESTDIR)$(BINDI=
R)
>  	$(Q)@$(STRIP) $(DESTDIR)$(BINDIR)/rv
> +ifneq ($(wildcard bpf_monitors/*.o),)
> +	$(Q)$(MKDIR) -p $(DESTDIR)$(BPF_MON_DIR)
> +	$(call QUIET_INSTALL,bpf_monitors)$(INSTALL) bpf_monitors/*.o -m 644 $(=
DESTDIR)$(BPF_MON_DIR)
> +endif

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v2 [4], does a single-invocation
"make all install" on a clean tree skip installing bpf_monitors/*.o?
$(wildcard bpf_monitors/*.o) is evaluated when the Makefile is parsed,
before the bpf target builds the object files, and it also looks in the
source directory rather than $(OUTPUT)bpf_monitors/*.o.

> diff --git a/tools/verification/rv/bpf_monitors/da_monitor_bpf.h b/tools/=
verification/rv/bpf_monitors/da_monitor_bpf.h
> new file mode 100644
> index 0000000000000..e9e673c2d1b68
> --- /dev/null
> +++ b/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
[ ... ]
> +/*
> + * BPF Per-Task monitor - uses BPF task storage map
> + */
> +
> +#define da_get_monitor(tsk) da_get_monitor_bpf(BPF_CORE_READ(tsk, pid), =
tsk)
> +#define da_handle_event(tsk, event) \
> +	da_handle_event_bpf(BPF_CORE_READ(tsk, pid), tsk, event)
> +#define da_handle_start_event(tsk, event) \
> +	da_handle_start_event_bpf(BPF_CORE_READ(tsk, pid), tsk, event)
> +#define da_handle_start_run_event(tsk, event) \
> +	da_handle_start_run_event_bpf(BPF_CORE_READ(tsk, pid), tsk, event)
[ ... ]
> +#elif RV_MON_TYPE =3D=3D RV_MON_PER_OBJ
> +/*
> + * BPF Per-Object monitor - uses BPF hash map
> + */
> +
> +#define da_get_monitor da_get_monitor_bpf
> +#define da_handle_event da_handle_event_bpf
> +#define da_handle_start_event da_handle_start_event_bpf
> +#define da_handle_start_run_event da_handle_start_run_event_bpf
[ ... ]
> +static inline void da_reset_bpf(da_id_type id, monitor_target_bpf target)
> +{
> +	struct da_monitor *da_mon;
> +
> +	da_mon =3D da_get_monitor_bpf(id, target);
> +	if (likely(da_mon))
> +		da_monitor_reset(da_mon);
> +}

[Severity: Low]
Should RV_MON_PER_TASK and RV_MON_PER_OBJ also map da_reset to
da_reset_bpf()?  da_reset_bpf() is defined here, but without the
corresponding #define da_reset macros it is unused and any per-task or
per-object BPF monitor calling da_reset() will fail to compile.

[1] https://lore.kernel.org/r/1081b7a0f143f29745409a1356f223fd8b196c827e18d=
46cde7f41716def72c0@mail.kernel.org
[2] https://lore.kernel.org/r/1081b7a0f143f29745409a1356f223fd8b196c827e18d=
46cde7f41716def72c0@mail.kernel.org
[3] https://lore.kernel.org/r/1081b7a0f143f29745409a1356f223fd8b196c827e18d=
46cde7f41716def72c0@mail.kernel.org
[4] https://lore.kernel.org/r/1081b7a0f143f29745409a1356f223fd8b196c827e18d=
46cde7f41716def72c0@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126130004.1271=
55-1-gmonaco@redhat.com?part=3D13
