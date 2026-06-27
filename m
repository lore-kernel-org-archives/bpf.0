Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A93AD50B
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782573928; cv=none; b=eDDG21OmkjlHpSX5EJgjOYbr9gbgg5tTkeuQX3TG0xQnZZpjz3qsrZ7WmcAPJIFL4rLqo2PRMKu7I2pumj78tmzvVK0eGf40oeHEfpI6/MouVfl0ssrXOpYE2cH5835v6eMMnAUqNo+7X4fLxZhHClnz+PqoDnrPe/FH+WyHSns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782573928; c=relaxed/simple;
	bh=7GpzxWKnpY1VW+5Xjxj5WhvOmNP0jtcozCQ0DIkuVnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EZo4+lDmCghZaQc14gQR6cjjvAVgSigDoZ6vUWqhnKLAg+IuyhMNpuvK161qTbDY9GVs9D6HxQ91KEE2nEWSIYEjMIzRee2WT/UEfyDryIEjJsW9OvoDe3mMlh508Laj8H9DuCXcRY4Isfyyl7sNWGQFncqauZarXzTYnnpl9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpY05lyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpY05lyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254711F000E9;
	Sat, 27 Jun 2026 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782573927;
	bh=7GpzxWKnpY1VW+5Xjxj5WhvOmNP0jtcozCQ0DIkuVnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mpY05lyCdmzcsnpViAYby2TtEVq/t85U3yRs/DZeQrncaKlcl+H2ZjqbmgJx0JcNe
	 LbJIkB9ccyKJgu+dYh0AevsVQWS8QxiPhFZOobOD/LqmyADgDKAGOw+uPmu7c8j1fQ
	 th4b3IdDMLN1bDLlwAQuAwUTFE4vG5D8KZCVTkNNNV9nTvvAvZu5Xoyqtv9qB4aWAB
	 XQlX/eEoCd+CnQ99wUW6FzC78HbDzQhuLoBOZ4U4iv9YKM7iEIRrv7sKGN951ePCWx
	 C4X3ppsOALWl15iFsSpVwNDBVsaRnjBYw8Q8bVU8/6kbYqgo038GKwZTjY8FU8TwCW
	 T8m3prxdeYiMg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 12/12] selftests/bpf: Add tests for bpf SDT
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <04b17848a1b9bf61c27317075829cd9570aa8557.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <04b17848a1b9bf61c27317075829cd9570aa8557.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 15:25:26 +0000
Message-Id: <20260627152527.254711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect relative include path for `bpf_sdt.h` causes compilation =
failure.
--

commit e66dde4c8db25d960e4cc2ec8a78a2fbb3113bee
Author: Xu Kuohai <xukuohai@huawei.com>

selftests/bpf: Add tests for bpf SDT probe

This commit adds selftests for BPF SDT probe sites and observers. It
includes tests for argument checking of the observer program, multiple
target programs in the same ELF, and programs with subprograms.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_sdt_target.c b/tools/t=
esting/selftests/bpf/progs/bpf_sdt_target.c
> new file mode 100644
> index 0000000000000..e1c14b9d7e9a2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_sdt_target.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../../../../tools/lib/bpf/bpf_sdt.h"

[Severity: Low]
Will this relative include path cause a compilation failure?

Starting from tools/testing/selftests/bpf/progs/, going up four directories
with ../../../../ lands in the tools/ directory. Adding tools/lib/bpf/bpf_s=
dt.h
makes the resolved path tools/tools/lib/bpf/bpf_sdt.h, which doesn't exist.

Should this be ../../../../lib/bpf/bpf_sdt.h or perhaps just <bpf/bpf_sdt.h=
>?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D12
