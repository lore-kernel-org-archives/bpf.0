Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745057;
	b=u2N8CPudmIc/gF0RLyekgmKHRFLDrF3yf78wxqP/LbjUZUmiYUI/4ZGZxeJrnnNKpyt0
	 P8kZ53OOP1poze4+/DLy4t14fTkbuM9vseWLkpf8WQYxJGPFUXMuYU+09QKtHyobkhqBO
	 EB1osxjb0eXsuoPd5wbezIoGb0HMiNlrl3izm/eFktwCcg+O1Owl4Wtrtw6rjjb8fNfsg
	 5VCnPNB3jxPcso6+VkhoKfb3+0/9dS45/eAufHsiZw2VwJgZ0gPIgpzo6GUmq/u3f/VMQ
	 U+bDrb/Snfri3jN56BjMEiztDKoZR2w8OasR5z0EFXMfscBHC3zYBCsOXOLOAHofTcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745057;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=jR34NGZ61TpHfusisNrWeWFWjKfnQMBDd7J0gfV9A00=;
	b=qrpfxdpp+sW1MemDElOLb8loRLVvCcymE6rbwLMpn7UnWGQ30Ui/4MXMXmip/eLz9HIc
	 0uMy+ro5zaO2/P2F6/R4kSEgF1RsxvOfqAmhq8i5lJedPj74keLJfXQkTS2f9DU07jn5o
	 sfj34qQlBVVONxywSnIoRlmerwg161522KAJMH/qwI9ub3NChUI1uFB39n3Co3eBBh7dx
	 ahZwGXtQvvzIVuH3Ixe8PsWO5Pz3leASsVg5xYw9ujnzb37vdc7MVtes5nZ79s3Vwl2sa
	 WkTHs86uGcl2qrVrVlXQlsO8p+rMgWDcph0BBD70zb5+gsmtHmO5/4q1Ea0orRqr7OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obEQ2k0u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401B606A31B;
	Tue,  3 Nov 2026 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obEQ2k0u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20651F000C1;
	Tue,  3 Nov 2026 22:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745057;
	bh=jR34NGZ61TpHfusisNrWeWFWjKfnQMBDd7J0gfV9A00=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=obEQ2k0u2ksT03QsD+eQpW6bjWMvgeL1N4qzYIM9yjqhPNMdTfAk8Z005vmG/2NLO
	 7zIUzA3fSdv1dn2D9yyze4lDXFzJUy1SY+FJN5hMeJIm8M1vsgzFquRCE5ouTW26fT
	 M0tGlRQdlqZtzm9eCEpZNiSsCYvP5tBGB+2qzn5FNqV/uyTrK1ACOSw2ouRImggUGL
	 6a2z2DBF8TmuD5t/ZE40IsgCxVUn7N0PrPUKIqRNMp0IRGLtbxIAZnjpxSEUF825y2
	 BHscCNSV3qjsr/J2qWgmitMjujDR1jA0ZfIT4ADfko5i6HpJY0/yjNabPhptpq4W+T
	 v/knV1lUt14xQ==
Content-Type: multipart/mixed; boundary="===============2477829407028560827=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3f89e3df5173e081e45425852c59a5a32cc979ee67c37ab53cd563da24a98572@mail.kernel.org>
In-Reply-To: <20261103215309.19950-1-dennylin0707@gmail.com>
References: <20261103215309.19950-1-dennylin0707@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Account for zero extensions in patch list expectations
From: bot+bpf-ci@kernel.org
To: dennylin0707@gmail.com,ast@kernel.org,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,iii@linux.ibm.com,bjorn@kernel.org,pulehui@huawei.com,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,dennylin0707@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 22:30:56 +0000 (UTC)

--===============2477829407028560827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Account for zero extensions in patch list expectations

TL;DR: Commit message only: the Fixes: tag names a merge commit rather than
the commit that introduced patch_list_insert_in_front(), and it lacks a
preceding blank line.

>     selftests/bpf: Account for zero extensions in patch list expectations
>
>     patch_list_insert_in_front() checks the translated instructions around
>     the call of an inlined bpf_loop() and its callback. On s390, the verifier
>     adds zero extensions after the two 32-bit register writes in the loop.
>     The call is therefore at instruction 25 rather than 23, and the later
>     instructions checked by the test are also shifted by two. The test
>     fails despite the call and jump offsets being correct.
>     Use the corresponding instruction indices on s390 and RISC-V, whose
>     JITs request explicit zero extensions. Keep the original expectations
>     for the other enabled architectures and retain all branch offset and
>     callback entry checks.
>     Fixes: 57fae4059380 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.4-rc1")
>     Link: https://github.com/kernel-patches/bpf/actions/runs/41696128762/job/126138168160
>     Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

The Fixes: tag names 57fae4059380, which is a merge commit.  Should it name
the commit that introduced patch_list_insert_in_front() instead?

  Fixes: d86e6695cb2f ("selftests/bpf: Test the tables that follow patched and removed instructions")

Also, the Fixes: line follows the body paragraph directly.  Could a blank
line be added between them?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41728315768
--===============2477829407028560827==--
