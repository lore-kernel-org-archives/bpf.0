Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95C31A556;
	Wed, 30 Sep 2026 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752775; cv=none; b=rkWud6Nh+1phDmSMdxUYj0vU6mf2E+0Vrcm2UoIA0R45S7+LN8gcQmnLds9WVCeY9KcHcUSnYN8arnHvQpDoK/dz7o7LpXDuWhn7R7GFP1pud7rkqKln8te2+G/vozFzz8xJNE2AwjLPbBSylEzDNtaxAhnLFTaOfkrKC6Q8V8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752775; c=relaxed/simple;
	bh=Cg//ITPdqfuNaFR91NI9QSHZ7mOe/lST6DXYQYChwZk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HzSTrjqkv9NCK2i0lt9I5oqjAEV72OGpdVGgstqbCICaR3haiVO6c9IrDkrzHT0dhS4XXRoblnOpQ5IDMCYE4Y6MbX1lI8qJ4yVOu4vmjz243UDAtjaNZq6D3u92w7Uv8irSZJb2JyC4o7RWkeBjbI9sqQ0Z/DOLUWKju8JBRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpQtu1br; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpQtu1br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9F81F000FF;
	Wed, 30 Sep 2026 07:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790752774;
	bh=qnv+opTRDPANaSFQkeJoX1GGPFk9FRRdrtoPqu98EGc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DpQtu1brqDYI0JzdSm5y+euWY5T9SGIo7MlwWtm639O0vN83LM1TUiqL8PwT+j1HL
	 rKTaW1bE8EFpO/nM+5K3uo94NyyMJ2hA8rktUSNW+BXdHzBWc9OYnnY8Tw5rA9zSsQ
	 oTGYW7LkzTfbAvT1jwjtovMl63pfrlkF5cWQTFFzkXBUVAG+7tGaoIjLdJZTtiuAU7
	 +Fkr+75CyEJYkPNhgbJcalcnzIS40Z58ujBXjKDU0hWuignxcL6ekA+//YDI9juUVw
	 EKePpuAd+edgnHADpNodXla6aUc2K1I0r8e5AMCy2IsMHZfnWE+8xu4CN/T/6j61kD
	 ihuQTp4kunq1A==
Content-Type: multipart/mixed; boundary="===============5540256240712805578=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f5ed8c5179098109e321e1cc42ced4bf30fc4bf80603fdaeef517277f38834eb@mail.kernel.org>
In-Reply-To: <20260930064607.1908864-4-pulehui@huaweicloud.com>
References: <20260930064607.1908864-4-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Update qemu config for riscv64 in vmtest.sh
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bjorn@kernel.org,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,alex@ghiti.fr,pulehui@huawei.com,pulehui@huaweicloud.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 07:19:33 +0000 (UTC)

--===============5540256240712805578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Update qemu config for riscv64 in vmtest.sh

TL;DR: The new '-cpu max' riscv64 option in vmtest.sh needs qemu 8.2.0+, so
cross-runs on qemu 7.2 to 8.1 may fail; the "v7.2.0+" comment and commit
message may be stale.

> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh

[ ... ]

> @@ -36,13 +36,13 @@ aarch64)
>  	;;
>  riscv64)
>  	# required qemu version v7.2.0+
>  	QEMU_BINARY=qemu-system-riscv64
>  	QEMU_CONSOLE="ttyS0,115200"
>  	HOST_FLAGS=(-M virt -cpu host -enable-kvm -smp 8)
> -	CROSS_FLAGS=(-M virt -cpu rv64,sscofpmf=true -smp 8)
> +	CROSS_FLAGS=(-M virt -cpu max,sscofpmf=false -smp 8)
>  	BZIMAGE="arch/riscv/boot/Image"
>  	ARCH="riscv"
>  	;;

Is the "required qemu version v7.2.0+" comment still accurate after this
change?

The riscv 'max' CPU model isn't available in qemu before v8.2.0.  In
target/riscv/cpu.c, v7.2.0 and v8.1.0 have no riscv_max_cpu_init() and no
TYPE_RISCV_CPU_MAX, and v8.2.0 is the release that adds:

    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX, riscv_max_cpu_init)

The previous '-cpu rv64,sscofpmf=true' worked on qemu 7.2 because the
sscofpmf property already exists there.

On a non-riscv host, run-qemu takes the CROSS_FLAGS path and runs
${QEMU_BINARY} with "${QEMU_FLAGS[@]}".  With qemu 7.2 through 8.1 (Debian 12
ships 7.2, for example), qemu-system-riscv64 would fail with "unable to find
CPU model 'max'" and the script would abort under 'set -e'.

The commit message doesn't mention the raised minimum qemu version either.
Should the comment be updated to v8.2.0+, or should the commit message state
the new requirement?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36681333169
--===============5540256240712805578==--
