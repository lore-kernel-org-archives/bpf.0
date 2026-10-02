Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF06309EEB;
	Fri,  2 Oct 2026 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901779; cv=none; b=uaHLJDqeccaLy5djk12fVui54wWJ1d8Y0xwZtJ8zMtkXFP+Td4ogYPh93KHpFblH/OUcaytabUy15Nw0qMHcV2RTAnhyxNkpNpgj/B++L0YhXVkO4HdWW0wIUmD1mB36dWc8vr8k0EGNRlxH7nYnuv9OgqTAtwvvbkANSz7cgmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901779; c=relaxed/simple;
	bh=xlDEjZZKuSLha8AII70E2wBWYiGTxzyZ/6Eyq94vTV8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ibq1s4z0eiQdz7pAGm0h56Qtd3CfqcfvIrFtOfmMSufsKUHlO8Koa6Qgf49C6kOfJuimJhA2RXwhqx97Zvvuu4C7pg7fZiPDvtsWLlXyxSw5T+g16BJ+JyXSNnBDTv4lFdkfpJUXZcUbLzE3Q4EqoSIo21fNq2UukUkwrRIOycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbdFKNsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbdFKNsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412DA1F000FF;
	Fri,  2 Oct 2026 00:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901778;
	bh=nFLFXcA/4RBw2fj95Jket0MhjElIbHt78J88KbonwBU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QbdFKNsD/PYFOLm1QVvRNYcU0boOaYOQX50XTYWcHi6uY2UJqav8DWnM5UflhK84e
	 q1g2LQxMI04mXR8H8mTQmYAnQOC4hmVcu99++0BW4btQ+QP57SEr4KmSmtdStVgFto
	 JLHsuTAXxrJzyraWlQkIOUgIlDF1LsOftdZIWktsuI3rsR6lihv04/Vpk/Qtxgv/NZ
	 OHb4x0gujuZTjrEb4NTpmnjH+m7P4Wph6DLJhWjUU6SUUi9wpQaUqBRwSIhLKKQgG3
	 bup2ufKY9PWEMHkRTDMWjT5YaaQ6qQaQJR375xNeEMLxq2yL4AekNNjgw8MHfzchi+
	 QsD8AIQNX1fwA==
Content-Type: multipart/mixed; boundary="===============8121513199621662962=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <80c5e55099a95df4966760c0ee7022cbcd1b57b379412c45b5706f6b0f491423@mail.kernel.org>
In-Reply-To: <20261001152042.124445-10-gmonaco@redhat.com>
References: <20261001152042.124445-10-gmonaco@redhat.com>
Subject: Re: [PATCH v2 09/15] tools/rv: Copy stripped bpf_atomic.h from libarena
From: bot+bpf-ci@kernel.org
To: gmonaco@redhat.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,rostedt@goodmis.org,gmonaco@redhat.com
Cc: alexei.starovoitov@gmail.com,namcao@linutronix.de,wen.yang@linux.dev,tobias.schaffner@siemens.com,vmalik@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 00:42:57 +0000 (UTC)

--===============8121513199621662962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/rv: Copy stripped bpf_atomic.h from libarena

TL;DR: The CONFIG_X86_64 kconfig extern in bpf_atomic.h may make BPF monitors
fail to load (-EINVAL) on hosts without a readable kernel config, but only in
the bisect window until a later patch fixes it.

> diff --git a/tools/verification/rv/bpf_monitors/bpf_atomic.h b/tools/verification/rv/bpf_monitors/bpf_atomic.h
> new file mode 100644
> index 000000000000..f834ea91c9d3
> --- /dev/null
> +++ b/tools/verification/rv/bpf_monitors/bpf_atomic.h
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#ifndef BPF_ATOMIC_H
> +#define BPF_ATOMIC_H
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +
> +extern bool CONFIG_X86_64 __kconfig __weak;

Can this extern make every BPF monitor fail to load on a host that has no
readable kernel config?

smp_load_acquire() and smp_store_release() reference CONFIG_X86_64, and
include/rv/da_monitor.h uses these macros (da_monitoring(),
da_monitor_start(), da_monitor_reset_state()), so each monitor object ends
up with a CONFIG_ kconfig extern.

The __weak attribute does not make it optional in that case.  In libbpf,
bpf_object__resolve_externs() sets need_config for any extern whose name
starts with "CONFIG_", and then requires the config file to be readable:

    if (str_has_pfx(ext->name, "CONFIG_")) {
        need_config = true;
        continue;
    }
    ...
    if (need_config) {
        err = bpf_object__read_kconfig_file(obj, kcfg_data);
        if (err)
            return -EINVAL;
    }

bpf_object__read_kconfig_file() returns -ENOENT when neither
/boot/config-$(uname -r) nor /proc/config.gz exists.

Once f5fc86049b84 ("tools/rv: Add BPF monitors") includes this header via
da_monitor_bpf.h, open_bpf_monitor() calls bpf_object__open_file(path, NULL)
followed by bpf_object__load(obj).  That load would fail with -EINVAL on
self-built kernels without CONFIG_IKCONFIG_PROC, or in containers without
/boot/config-*.

The series fixes this later in 3b66b9d4a13a ("tools/rv: Define CONFIG_X86_64
statically for BPF monitors"), which passes .kconfig = "CONFIG_X86_64=y|n"
through bpf_object_open_opts.  So the failure is limited to the bisect
window f5fc86049b84..3b66b9d4a13a^.

Could that fix be folded in before f5fc86049b84, or could this header
resolve the architecture at compile time, so that every step of the series
stays loadable?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36944413541
--===============8121513199621662962==--
