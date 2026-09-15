Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1DA3546EA
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489380; cv=none; b=sxGwUBTa57EXvWz/RpZRvvP8SqrWzlQWEtsA1LiBr+pA7ut3hN0bb8zo3vLizcAmQrI8kommGC7v0p8rbm3ArV0iOrlLXv2Nsef7up/NZJMit0Y4tSRLGz+QCJezsSlCPGYHXGvNgdqS2VP1hq3Ky4djph9WSqjdXA6iQewJvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489380; c=relaxed/simple;
	bh=9E0SiGlVikNF/sbHMuRjxCSmaye0mmTJ+XlqH9sA3OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5mCXKhprvv3yIcuatbKPYf8JUqQ34BoNjnXR108ZldJ6c44XllV6tdHmbZj8MJ/6R7BnG4/4EaS2slGP00o+3GwM/UeNXDiggr7lEYBnn/d/GH5YxCaXPUgOJsri/UwKtOZ21VMZyoz96fOxI6nbrK0uXgJz3+7G/uRJ9vLefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X54Lj6C8; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X54Lj6C8"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f20513so410309b3a.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789489378; x=1790094178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OwsT7SF4ncp6wr7FoSisa/vmmlDt4ArJiNE+SOE9NhQ=;
        b=X54Lj6C8f88FQoJ0AMamXn/28uzdFi316Szmom0FMxdhs4hFoK3ti04QOJGXebRbsU
         MMwasEVpGFDgtvJfeg/2NVSeaRoK8yfhwfliVaiOpMubv7QA12zigkPyNR1DbgFXvxNa
         T9OOeohN/69YLlcP4yodEOn93IGUSJfh/MaGoMp9X1ddfBcNIAQ/4w4TNJGsQLCF5BXH
         WNKS8Dega8xr9+5NhEz6mFBr9VkVdc2dKUMXvtYWNJrIgxvw99Vvd6AOpmyHLRko2rUL
         fwlZwutCCwGQiAb8Cnd3CFPgmKIFBqyv1bywZF0nhETMYYRUxIanl99O5QDC3ZnARPzg
         UsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789489378; x=1790094178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OwsT7SF4ncp6wr7FoSisa/vmmlDt4ArJiNE+SOE9NhQ=;
        b=LluWiROOtUVD0sas640ID48BbqWNbF7nRvjv7ATUplvrArskelHmU3kOcLW3n6jhW0
         fCWzRuI0jQtIWUvhw+IzZQXBgI8rGr5KOgH0Nxy2bskQKybpItaETQYYW+klS0xZqaPs
         7BJv+BDea/UGMgRENansf2f3OGu3Pv3oAH/vMmpLkKmunUJ2j8291mHUikSybZgvGxES
         N0CUhB4NohV+/6d66ePuH2Rn/n8F1YYy9WiMVXRo0dsHpZH4YikBgOvMr/k8yScowJFo
         afSJ1bs2nX5bUHmEmoAstPT2CZ973Z5E4jRvky7i+XbQdz63uEhj4BEYZfTaOvHfSvGX
         NKpA==
X-Gm-Message-State: AFuF++kYOEmXAq3C2NyrFZi1Z6WkqxjotJp99UTlCm7Tk7dnKv0gAJx6
	gLQp/S00maXWkmhhk5uuoCeIOaL8ahkgW2JPW9bFmPuS7YjaKinhEBVYMaswFt6y
X-Gm-Gg: AYBFou2b0Zr6rLseR4OSZ27j69ZBoJCXrWrRuwwNhsRGELBFVqfiGfhkpPHBUSTM13b
	EZggR8+azAmDcKeA5Vggss9RruIaw9mttZ+MjaT15klRW+i96VKoWF5+0CLTHr6btnzWsoVcAKa
	KYAhd7RD7g6L3HqXWgO70S8JoCLIJdWb1UGF0ubVnv/Llkm6xJFC1nYNmH/7a0x4sJQ7xptrG/a
	H8zDgwbdQiXcDBv1lPShViBZiQgWz5t/x28NsB+6QeWCNuHu4Rp8JDs/RF7sbMYPs1rPFC+M71T
	m5gc26Z9eLTxX41WFvk22PcwvxmNQhSX+9W9F9ypN3Van5NyvDpYcegd5ZFEmDURutM+1sITUsL
	mdpscvq7Zck5YZGxG/sacCh8Cr9FUrsIdssPK+bWG4Jv8uPyYILxictMDGZ1slfW7BKDY2HNDpZ
	JCrfsiJ1V2hbeKTJhu/LH1ijdVhPpBoiEEQw1wMdsdZ/UQfdS8j3ZHBLto+cKja0MoHTbMLgfPi
	Lmz9h/veYmUv3YpVfg0w5ec7Zk1TW13SQdy+ck5BXyMTXwLleko/So=
X-Received: by 2002:a05:6a21:400d:b0:3da:5b4d:a89f with SMTP id adf61e73a8af0-3dd5295fbe5mr3739603637.27.1789489377877;
        Tue, 15 Sep 2026 09:22:57 -0700 (PDT)
Received: from ubuntu2204.comp.polyu.edu.hk ([158.132.255.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50aa988e2sm208232a12.1.2026.09.15.09.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:22:57 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: Mingpei CAO <caomingpei@gmail.com>,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf v3 0/2] libbpf: Reject local struct_ops bitfields before data access
Date: Tue, 15 Sep 2026 16:22:35 +0000
Message-ID: <20260915162252.473044-1-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A local struct_ops type can contain a bitfield absent from the
corresponding kernel BTF type. libbpf calculated the member data pointer
from the encoded BTF member offset before rejecting the bitfield. The
absent member zero check could then read outside the local struct_ops data
and crash libbpf.

Patch 1 rejects local bitfields before calculating the member data pointer.
Patch 2 adds a negative test for a local bitfield absent from the kernel
BTF type.

AI assistance was used to prepare the messages. I independently reviewed the code and test results.

Changes since v2:
- Restore the local bitfield check from v1.
- Drop general offset validation and the bpftool changes, which covered
  malformed BTF outside.
- Describe the local struct_ops type and absent kernel member.
- Keep the negative test and check the load result before the diagnostic.

v2: https://lore.kernel.org/bpf/20260913145233.1446643-1-caomingpei@gmail.com/
v1: https://lore.kernel.org/bpf/20260910172340.1467764-1-caomingpei@gmail.com/

Mingpei CAO (2):
  libbpf: Reject local struct_ops bitfields before data access
  selftests/bpf: Test local struct_ops bitfield rejection

 tools/lib/bpf/libbpf.c                        |  9 ++++--
 .../bpf/prog_tests/test_struct_ops_module.c   | 32 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   |  7 ++++
 3 files changed, 46 insertions(+), 2 deletions(-)


base-commit: ee363e055895364039bf28348ff13c615afad4ba
-- 
2.43.0
