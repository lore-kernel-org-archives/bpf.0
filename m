Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793936231;
	b=asxo5SnC49lZ3vVr5O4/uvU3zYN+NlYY7raBUwaCdMkjnl+tzaetBDwathnlnWyYvZZE
	 Q30hLCwdQhq3nikdi+eFpFSxkSwnjJ6dmY+TX4a3sOdjnduFYDHTJtLjhtgMCZyqoBDyp
	 f2ulCqSHPTTUq+ULcPDEmNzh68UBOoR/oCjwePPzzgjh00pEbb2WuUjWj1ElMcnxTXeNu
	 NHJaA8z0TtIuHHoDyZPtPr7+zqlhBJK0xx19+Bp1sJNxwdEn3F+zsDrRNXxKvY32PkH/B
	 HesfRcLAYQ4o7GSioXy8PWDcr8P0jV88rxfUcIFTa2zaU66xwkNlqOCR9NzFjXPprig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793936231;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=RcMM7MZM6uzvIUuTPeaVMN2uDr8MEAOtjZHpEAB0erg=;
	b=AXIJFPPdVy+4MV962/TiOA8ijTU4UwrXuw7LolAWqCRYIFUUD7Osl6lBJFuWJUsmvw2n
	 bUidYsZQ4ssjiwCwRdygm4ap2jbMT+TNGrTitI4/m7PJJ8BofTrY2VaE0wpvd0vWM7DXt
	 b5S4DZ7rAFgnPnJYYAww0++VpPUQovfnT0emKFyiDNPS9oIfL4M7W2Y5zXpffXPBbxux2
	 pBPiEKnGrfnY9kNK7prK6udFHSkRVct0GIZIO+Rp+jIQPfrrU4zvjegkmpTPfD0n6/K5q
	 4LZcmW5T8zIgv/oPtXYw71GFWn1rQD8p4WMQ4uOGDFov/sjbaYnftZxxUR+cEIX9osg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAU0VCmt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36D606A31B;
	Fri,  6 Nov 2026 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAU0VCmt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793936230;
	b=H9ZSKbZoToBzSdmP+9NKOnkg1L3n9xvB5iDaJ+36jBX9WW+aV+kDLoZLPp/sDizGapmz
	 q2CK4cqYzaScfYhAVLwYbIQZ4LoowFUfr5eEo3nIBMvcYfwT1NlHO0RDdVcJHWyBGqFrR
	 XFbmA1GMiXsIsBn1yyPLMISYMD1f9DLQtRMaVPKyxKvF/NoLrmiA+JgUn1G1RzpASo4pK
	 xAefAeCQ7K9aO4LjqyADi1irXUiMv5fqrknyQpYaGAYWzQSbQHsWGyT/f60CElmgwz8CV
	 tlhDvG3sAGymnSXFWDo6fNO88rwhsDk7mOYOH4Ovs6fOXNWeIYqNX76xeEdBvxkMJTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793936230;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=RcMM7MZM6uzvIUuTPeaVMN2uDr8MEAOtjZHpEAB0erg=;
	b=eJUrYYCwf1feC6j6wLoNCgG6nSRtin29gJf501rp1tO7+B5Je5AjcNFw44ibaX1zRKnm
	 VoG7qZ314eOM3ZOkhxMWG3/X7CPNJPUC7YKQWcf0ugjhWSTDytgDigvoxeK7UMmoj1R00
	 t6Wagf8jhFFxudMJbaAPrJdm8zkJZl2FXZAeha/5tAds506CeiyEhT54dDFwfmSQZVH1s
	 +2GkvTTJQyejyWkEPaC7mEd7efqX0RtgiGkHx9uvPLcG+bngdAWcX8Xx+ieppTgBj1hzd
	 evMgyTCYedrIwSZIcjWhe+VNnL/YbWiNjWDdP1Ck/KegCrNIl29mLUPQsvXI97oCe0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4315C1F008A2;
	Fri,  6 Nov 2026 03:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793936230;
	bh=RcMM7MZM6uzvIUuTPeaVMN2uDr8MEAOtjZHpEAB0erg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HAU0VCmtHovBlbFmpMoez8aKQtHw7riGzOqST2ZND//DSzJfM2LNGswZb9PT99bfl
	 RdiXx2lebxvWKuCJBnN9BdGMPHoFKPxS2S9eJOynHUvnagRdZ7erNz5IJ8y7LxuSBd
	 l4G8DXRE/to4zLqPYJVi3Gk0BIoeho/zp3gA/NwPg7Z3MR+1lg+ovWatVmIPRUlqbs
	 01xC06YDZqR/+ptzhePV1w1C/P1Lk3+kMvZLq6IbqCW/hknXiq/J0q/K8xviD/fIxG
	 jmp0reS1z4Qg+OMihJtu5ubAl+xBnCU1B2qGAYv/wDa9WbcQXCFEl6sHE89zGcOLmB
	 ElYeMRTWSkZnw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 960EC45B9E;
	Fri,  6 Nov 2026 03:37:09 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] selftests/bpf: Fix d_path check_mem_access and drop
 CHECK()
Date: Fri, 06 Nov 2026 10:37:07 +0700
Message-Id: <20261106-dpath-memfd-v2-0-1dc0799b4aa6@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03MQQqDMBBA0avIrDslSZtBu/IepYupmZhAo5KIF
 MS7N3Tl8i3+36FIjlLg0eyQZYslzlOFuTQwBJ5GweiqwShDWitCt/AaMEnyDlkstU7ZtrMearF
 k8fH7vz1f1T7PCdeQhc8Pgw5Pk02jRuoMW6L7+0auHxPHz3WYExzHDwzAaAOhAAAA
X-Change-ID: 20261106-dpath-memfd-ae568d05895f
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793936228; l=1020;
 i=thamrinjonathan@gmail.com; s=20261102; h=from:subject:message-id;
 bh=oHBYZOmhLKtt3g9DkPVwr2isJO0GLayzgSm6warDTzw=;
 b=QjyMQE8ho5ZRgpHMESZDc79jLl+iy65YXwkJJJNeITymJxj8scp6bNke1eolxQt1dwHL8Uau1
 7/b1HfTiWzOB9/Kn2fU3VXurUzb59ZdKo3rY+5RA5JV3YhBycer2kEO
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=mr0q5PZVaUIrv8WvTxIfK7QVcAiRSYI8hOByBQL1ZRo=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261102
 with auth_id=1383
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com

Patch 1 replaces the deprecated CHECK() calls with ASSERT_*().

Patch 2 fixes check_mem_access, which creates a temp file in
/dev/shm that isn't mounted under vmtest.sh in local runs. This
causes mkstemp() to fail with ENOENT. mkstemp() is replaced with
memfd_create() as it gives a shmem-backed file with no mount
needed while still reaching vfs_fallocate.

Changes in v2:
- Added patch 1 converting CHECK() to ASSERT_*() (Andrii)
- Link to v1: https://lore.kernel.org/bpf/20261102-d-path-memfd-v1-1-692a5664b36d@gmail.com/

---
Jonathan Bastari Thamrin (2):
      selftests/bpf: Replace d_path CHECK() with ASSERT_*()
      selftests/bpf: Use memfd_create instead of mkstemp in d_path

 tools/testing/selftests/bpf/prog_tests/d_path.c | 74 +++++++++----------------
 1 file changed, 26 insertions(+), 48 deletions(-)
---
base-commit: 87eddc739d20b466881e4c5cdd2ddf465a5debfd
change-id: 20261106-dpath-memfd-ae568d05895f

Best regards,
-- 
Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>


