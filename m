Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B1240FD9B
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027772; cv=none; b=ftfjeYCcBjUmCujNq97MXh56PCDq9ngzkI2+1pzWHcRJfcHmRZPjU3IIsyIxGgd9t4x2+2fwROze4yRsrgGN6js2cso8XMZ4Gke86ofKbKc+pt7eg0+vh0pTzZqH31xMfOOg6Vzt22awGjaO6QRu+n/TAaH1AbLjJ2GV7gbxcDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027772; c=relaxed/simple;
	bh=wjePPw3LEqp9kEWT/UnZBTNjGQk2ynjfimywxFiCums=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3/kfecYTE8csA+E70hCC952r85se1m7QdMZKyomLOAD6m+ipUIu4dYWO6kgHTaWClNBe/EAgcFG40uetlTxDUAX2IpUYDXC5/FpSFTuxFT+FXwdd64Vx2ECMaYidGPrkFB2VkJ4yUwlbdrEq9BqHHYcYKl9vz5urapISNAV2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=CMK1sTQc; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="CMK1sTQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding; bh=58LzmlIGxO7TE+EEjCj9ARbE+2cVfrA7UD
	gNDWDSLtA=; b=CMK1sTQci7YoWRA9fuRfLAdANe8jYrTp3K0NMXIa2j8cNie+Kj
	WgmhltZTT1kyQaNs7fTTFVYLxOSwiqCSqlB4MmdwFpv2vU2JyqQ1K1DwWlZv1TIZ
	ZlWg5MPRo30UuoqJNWhXXWXmJ6SZpM80ZTJ17l8jWxOcMxQ+tkM+94hls=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCnrDOxZaJqZEsAAQ--.3575S2;
	Thu, 10 Sep 2026 16:09:21 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Preserve escaped dynptr slice ancestry on subprog return
Date: Thu, 10 Sep 2026 16:07:44 +0800
Message-ID: <20260910080744.174069-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910050127.31A8E1F000FF@smtp.kernel.org>
References: <20260910050127.31A8E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCnrDOxZaJqZEsAAQ--.3575S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWfCFWrJw4rAr1DCrWxJFb_yoW8GF15pF
	s5Cry2qrWrJF9FvFnrJw4kXay2vrWSqryfCa48tryIy3WrGFyavF4j9Fy8Zrn8Kwn5J3y5
	Xrs8ArnxZa98A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07jVv3bUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Thanks for checking this. Both scenarios are rejected by existing
bpf_dynptr_from_mem() validation before the new reparenting logic becomes
relevant.

Although the helper prototype uses ARG_PTR_TO_UNINIT_MEM, check_helper_call()
has a BPF_FUNC_dynptr_from_mem special case that accepts R1 only when its type
is exactly PTR_TO_MAP_VALUE:

	if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE)
		return -EACCES;

Consequently, a callee stack address is rejected as type "fp", so a LOCAL
dynptr cannot be backed by that callee's stack. A result from
bpf_dynptr_data() or bpf_dynptr_slice() is PTR_TO_MEM and is rejected as type
"mem", so it cannot be wrapped in another LOCAL dynptr either.

The existing verifier tests pin both restrictions:

  - dynptr_from_mem_invalid_api rejects a stack pointer with
    "Unsupported reg type fp for bpf_dynptr_from_mem data";
  - dynptr_from_dynptr_data rejects a dynptr data pointer with
    "Unsupported reg type mem for bpf_dynptr_from_mem data";
  - dynptr_from_dynptr_slice rejects a dynptr slice with the same "mem"
    diagnostic.

All three reported OK in the 134-subtest dynptr run cited in the cover.
Therefore parent_id == 0 LOCAL dynptrs that can be constructed here are backed
by permitted map-value memory, rather than a callee stack or a referenced
dynptr slice. No code change is needed for these two scenarios.

