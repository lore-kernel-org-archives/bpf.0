Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493426;
	b=dwfa7NqjvMKkRppn75WSnXw7a44jIBhzalOEwPaYDWViEfIHU2FnkV5a8Hp7q8x+bTXW
	 Zd6DVpcNk1qxM8n4++GCsIabiJPlgJQ8V4+FCbKOHNnaA1SIgfMcSkQDTtaVmpR+Ry82k
	 AUIJ8+uazIL+qBM1CmGO54OLLnDZnrnBp1YRynb1jkSaThXI9dyp38fmmlU4Kt/QgcNl7
	 /8t7/qIqG0YEturwE6QPsFvNpwoPTMBIyaOHe6BLop4aF+9IGjC6eBT0mRpEvPu6sCpIV
	 HIoyeTs3zWeUuHTiF7ncJ9x8Z8HEkwbrqdJ62zBvnFIqhJ9g/e2ee/Zr8JhgFHsq0cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9Kv/ULeJ6pUo5Q5w5vFxVRD84tjRkymD9RFQwaVpcn4=;
	b=IjAQZFIhnXpiObO7iczY/LfcSaxbDOAFLi/6DTyvYsxNM8zrx1NQvxka0FDk3rTkmM3T
	 PR+U4QpWRVoI9bOY/7JLY3kNm6YPSwcSI2UwH1vjuYWpu6NI4t5Z2ncYMeLoCJSYodRyI
	 MJ9QK5VmOcjoXGNldmoGhDwe6IsKUK8IhocfatQvRCpm3wavOw0Jg7hXQeZ528YiBDk8t
	 lufl+ApzWfhl1kU3endDZOWrBF0RAeks+mMjqUCd8sdNotU65rTXTWE7AQZMyrQ+0bUKi
	 itU8tJ/r7ItmIX5cJct/8YuJBo8LTGjrfR9/FQA2eHbXLn01I2DzpLDO75z1S+Egv4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=WghxI3Up;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054060A2600
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8054060A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=WghxI3Up
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab98332238so2416537a91.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1792493425; x=1793098225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Kv/ULeJ6pUo5Q5w5vFxVRD84tjRkymD9RFQwaVpcn4=;
        b=WghxI3Up3cKf6RyLG617g6gp1fbtM68Tu0QayXyEvueWNs2uwXsB4pl+epAB0GzAHN
         lmgnE7YrMpwTUjbnDobBNSl6KXoekV1BoqFvYEesxFbS242lLJXNceTMlY8qARByCF/r
         b/+GtY+R7jR6F6lGmWoDWR1GR51bFvn7agdI/lDTvzCCvTs8QSVbkT0lJJLRFbeYxd1K
         0Byhx/WEUFCgoUA2/ybpWhk3c+BOiloYorMYFm+ZW7dFKwsxkgeC/tEDNocIbF4kC1Fz
         GG8BdTPf8Bggy3gvBxenoMElQ/OKp9g++QhNpGJud7t+aPKpkwvMW6YfiPeZzzqpJD3D
         Ip7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493425; x=1793098225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Kv/ULeJ6pUo5Q5w5vFxVRD84tjRkymD9RFQwaVpcn4=;
        b=NNDNI6RdJ0HSOKfsJm1B6pM4BAlugYw58HByQ7y3csQex07WGbVG3C5fl4tbXpIHo4
         gFMN2HsgG9vqpba7Rk/sRuG1PyaPLBggq+tB39ovx8zI5lXEXJ3UgrzSxQWHm/u6lUme
         0NuF4tpip0Eh5Hs1QMBySxzWrTxDlXFxJDjwu73RSUmJheOpUJVx6grQq7bSI3iblcsh
         C2t3XDw1osqlEvEjJ7ejFVd47E2RO+PSjLxX79nYTm+wjnGmD57pSPKLMNDZ64gCz5Gx
         3kurDhmreZWY/o+JEd5dGHPG4ndVFHB4JbBCKZ+GbHL57L7FfCHywBoN6tAI6WW7bQLm
         9ZAA==
X-Gm-Message-State: AFq9FYJzCPpisrRAXNBAlMyn9NiYz9OtQ5dZQfPx5aEYdMzMLBWmXD0Z
	k91Or3wizSbxKTuReXbMoFIu3LQU/JrXQLjI2bB2XCFXh1sFnXsJfbbZRdLitbFAVq+UhDcWMnR
	ZjxRzexQB
X-Gm-Gg: AYBFou3+jffz5tXRG0oLF1xDRahaT35zPG3OOUfhlNkGFz8WbWpNGIuRoP6/MbFfq4Y
	tQj6wvT1Z8pX/U8+C48S5ClS9ACBEuR9ZxxlW0afrERMsWT96jLRIaOvGUfYWA7oI9yL+FMaiBr
	t16yXeKYffr3XnskIQlOnJcNRyGRyQrEL14KJPnEoVMVBuy9PoL8r1uTw1/vK0TQtp9qjNi1eyg
	MyPQx/V3/+bQCpPjlZ7TTSwuLaYKhwb6NTi8+WQxyopC/MeHZUbYDFimNwJ9KJSzgxivymzNR49
	lytBSBrGEawmXne47fonOToHLYf2ptrPdzuy4Lg3NKNWG4SKMWTvP0HulOksjmDLFbl/hW0ndH3
	WQ21GqBKmhEXjwJFYPPhV6LvQNAyfzU+s6D/OJDx5kQ5CylpKbyfARl08f3GQ24ziGVjpKCJat3
	vM3lsdouRRpHKJB1CzgJa277XDxCMJY06nMm0GLAHRe2tAV1sOk/kPu4LIr+X1xXPEXJKziewjM
	46z1g0Vo8Uv3fMUEQ7mNHD7VpRj1rhyQudomIdySj/LeYIqSirtWt+Ct3AoqTu1tW/tx3+j5tPc
	fa67COSm0hyeT4xO4IbyX3S0oLY=
X-Received: by 2002:a17:90b:2cce:b0:3ac:b3c7:de14 with SMTP id 98e67ed59e1d1-3acef5c8cb3mr8447674a91.61.1792493424631;
        Tue, 20 Oct 2026 03:50:24 -0700 (PDT)
Received: from workstation.. (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f36a5asm3487902a91.9.2026.10.20.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:50:24 -0700 (PDT)
From: Matt Bobrowski <matt@bobrowski.net>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Matt Bobrowski <matt@bobrowski.net>
Subject: [PATCH bpf-next 0/2] bpf: fix crash in bpf_path_d_path() for exiting tasks
Date: Tue, 20 Oct 2026 21:50:12 +1100
Message-ID: <20261020105014.97985-1-matt@bobrowski.net>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_path_d_path() can run on a file released from exit_task_work(),
after exit_fs() has cleared the task's fs, as a BPF LSM program attached
to file_release does whenever a task exits holding the last reference to
an open file. d_path() then dereferences the NULL fs.

Patch 1 returns -EINVAL from bpf_path_d_path() when current->fs is NULL.
Patch 2 adds a selftest that crashes the kernel without it.

Matt Bobrowski (2):
  bpf: fix crash in bpf_path_d_path() for exiting tasks
  selftests/bpf: test bpf_path_d_path() on a file released at task exit

 fs/bpf_fs_kfuncs.c                            |  8 +++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 51 +++++++++++++++++++
 .../selftests/bpf/progs/test_path_d_path.c    | 35 +++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_path_d_path.c


base-commit: 0007654a7bf13ef2a19afd398bbc6507087f19fd
-- 
2.47.3

