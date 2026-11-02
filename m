Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793599600;
	b=vOUTTTp/pQTQI4fBdl3XfePd13i13yK2d+/Bbh4ce6bwfsoyqAPFMDBcNl673mYoNoLr
	 zoHR9BPePztYtGm7I4Sfm069bikKSUI+2aQQI1ht8p95EnWsWKiYhrujVTCm3sdfUJdeF
	 Uyszl+FRQSlhnaTxAbf6/IZuM/c61zBXkEksIzIxwVXHC9V2qAbnEuzfhamgZRy++AjnQ
	 5hqxWjR/ICvs2dybHQ/xDpVOEGp0rioZ/vFZiY57MX3TA3UKqiF2wQqZxXvTkCYt0JVcL
	 8UHVmnNSFb/Dl3arEZDLNUhWAF9bOR3+By00obRatqzjQZQyCXk5Npm0ihHBy09TIMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HWS8MhFAJ2J5PetrvH3US4jMd7S74sKAtV0trLDPeuY=;
	b=dYZysjoFCAgTxHjkujilt293GUaMr8DkcqaTIkSSIwPaXNwwNLNP88FGpuVeGZyaeFSH
	 9TiKaUvcz6y2UI7Qrr7w839wEW2orneAfh7SlyGi7F2srbmHxwHFq50QQdqemwFdOrAW7
	 sDXC0Ji30fh9SWp8zckA0F9lLWEuTrm1boKnzzl/oyykpg41T4LQurRtiqspHWAdzsrqt
	 l0wPX2UliE3UMA9GN5iXE2U+rbH2UFeUkXonv9BeP6f3zA6PukuOGOzKtYfAFHewjojl5
	 ZAZ4rR7LNKW8Rv3+gjL02JcPGEQg9ertgzNDZjq0w4dC7g8nXgHSw1Ky8uEMnl5kw/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YzHqBrWL;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE57606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 06:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE57606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YzHqBrWL
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1881802a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 22:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793599599; x=1794204399; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HWS8MhFAJ2J5PetrvH3US4jMd7S74sKAtV0trLDPeuY=;
        b=YzHqBrWLW4bCSzljXEEwztzgzgWiZZFvz0ZJOPqKhdM1A2movm+ZjJliJQPDkoecD+
         EtwulPdNqxdMty2aBDHyTtQDHzjxiHmQFUj8hgqxRLBtkD+DTV1gg9cY935wiI5RBbFZ
         HXIGhFLqm1UlUZJmUct64Xy48Y7foHBfFuWzh4OyBu7KXF4rmbEPZvrD55VWrhwj5qZg
         GFvZHEBv2iXZVHF7H8lHkqoQmGentiSDCoiX+S/6elij+WT6fWzmsUq1pL91+NlKL2tH
         TErLsXJ8V2Du1tx9bYpflZnSilK8MwWdtMR1HGtSjN9Nc7hg27QeVu9Gw4DXeWKGMMIo
         RF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793599599; x=1794204399;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HWS8MhFAJ2J5PetrvH3US4jMd7S74sKAtV0trLDPeuY=;
        b=mouwHYyNd6xcs8xWMt4zqnnM9Y5LpM8zAfzLM1L0FJ1N41IZ/vgipFyCtWJKZlfPzb
         BFZtC4BPivn5VSLS6HEryNHwYP63tKy/X3/LOH9tb+05LzK03W5wxclZQyCoi9IxSaEr
         UXq19NXcn3LuUksedJd3DaJVIvFIm2a2BCAt5eflzg+dIYdHEzDJ1Kmx9XfBg5mh6Mut
         0Fu+zVcdTBQCNqM3NL7/d1hgT85vNS/Y7jveV++e54+56wlCcoHKlE5StmNCzII0JSZC
         xZkAbrzX4EzJTnuOJM4Ks5Kd2wKjeRy4jmpDYz8IZCLMTi0IInrfJv01RzQK+zseu5FP
         gHIA==
X-Gm-Message-State: APuU4Z8wj5ijNSo/tveYMgLNvtFETANx3xpEbIxJUMJzLQIdMbtM2hdX
	hB/t0Aa0RFaGpivMzOJOd/+yaJYrtbHSh1XVm0OAC7FbDLtt1z7Egilr1GDsvA==
X-Gm-Gg: AYBFou1fzio+UKyGvXIPjuSodMvGo8JPQjTUsFty1dBzY1+G/XIKc2Bzvs0pfe9FDGy
	UePo5IayN2VcIWwi5GEWCc91GliSfp9Y35P/Vvi21g5qAMMN2OjnYwlqPK5EgUOJ93sd5Fc2HLS
	h4uKqzyLIuvbxSeDDgZ1a3tNoVAi+kftVwTgip6WBXp9LGmJXlXDoDhrRqcg4opDBKzClgVinmc
	OX3DMzRKI9tnBJzkV91bPhXd4ShxnrvJsLqJVtmo5UspTQxv48/ITIQv0XGsdsPBnjKr/YJ77e3
	U0pVi8wNCwQp3MhCbfinSyNNbFk+1C8jB/NHCFrAtBXg6Zq5tAYK1tdbvjNy5VQ7RQcSOefI4r8
	4cOjW4HfVGWY9S5/uzZMaeQ7+3s01fcyvPwDRk3G171DwG9I5jR0T5vCFSSH3eJmpPJPLM7pRBi
	8mZtnJXUhGkZg9IF1CYmNfFfKfF7UuuocueYThHtHtZ/8ruWZRbULdNF2e9I6FJhqkLJ+n9O94I
	r1mlNXMcYE/Z2gXjEmAYvU22NAbXmVRzFf01W0god4G39EXOExAsGVqWfCxfGQ34CNw8zBIrzxl
	r+USdYqLGzZ0eMpBHzUzIebDn+XOjMIEH6aqXC0pXZSdWPgZq1N3cgB0rWoVi4klKQ3VIOTKyis
	EJW3jAZlOtJSyzrSpcNXX1iwLuX9rgLUugQ==
X-Received: by 2002:a17:90b:51c7:b0:3a8:c0cd:57fb with SMTP id 98e67ed59e1d1-3ae89819925mr7854773a91.42.1793599599247;
        Sun, 01 Nov 2026 22:06:39 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb1ddsm17190680a91.5.2026.11.01.22.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 22:06:38 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 06:06:37 +0000
Message-Id: <DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <odys.yuan@gmail.com>
Subject: Re: [PATCH bpf-next v3 00/13] bpf: Replace bpf_patch_insn_data()
 with a list of deferred patches
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bpf@vger.kernel.org>
In-Reply-To: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
References: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Heh. CI is as green as it gets.

but here is what I expected bots to find out.. kinda disappointed in sashiko...
my local sash@#$ seems smarter... ;)

1. Patches 12, 13: the tests need net.core.bpf_jit_harden != 2 at the
   start.
   They are serial, so nobody changes the sysctl while they run.
   But they do not set it. With 2 at the start:
   - patch_list/line_and_func_info fails.
   - patch_list/poke_descriptor passes, but the prog has no poke descriptor.
   - 8 of the 12 verifier_patch_list tests fail, like every __xlated test
     that has constants.
   patch_list.c will set the sysctl to 0 and restore it, the way
   classic_filter in the same file does.

2. Patch 12: "jump pushed out of range by patches" matches only the fixed
   part of the message. The insn number is the part that the series
   changes.
   The test will match "insn 2 cannot be patched due to 16-bit range".

3. Patch 11 removes adjust_insn_aux_data() together with the comments that
   explain the rules for zext_dst and non_stack_access.
   patch_list_adj_aux() has the same rules without the explanation.
   The comments will move there.

4. Patch 5: veristat has no option for BPF_F_TEST_RND_HI32. The numbers
   are from veristat with an LD_PRELOAD shim that sets the flag in
   BPF_PROG_LOAD. The log has to say so.

5. Patch 6: no test has a second patch with a jump in it. That is a barrier
   in front of a ctx access that becomes several insns.
   "nospec, store, nospec" in verifier_unpriv.c goes through the merge, but
   it has no jump. The test needs a prog that is loaded without CAP_PERFMON.

Trade-offs. Not going to change.

6. Patches 4, 5: offloaded progs. verifier_remove_insns() checks for
   a fatal signal in front of each call of the driver.
   patch_list_drop_removed() does not, because it runs behind the last step
   of the commit that can fail. Only nfp has the callback.

7. Patch 7: bpf_patch_list_insert() is correct when 'off' is the start of
   a subprog and the list removes nothing. Both rules are comments, nothing
   checks them. The three callers follow them.

8. Patch 13: without CONFIG_BPF_JIT_ALWAYS_ON classic_filter cannot tell
   a blinded filter from a silent fallback to the interpreter. User space
   cannot see the image of a classic filter.

9. Patches 12, 13: lists of archs.
   - The tests that compare xlated insns run on x86-64 and arm64. A JIT that
     needs zero extensions gets one more insn behind 'w0 ^= w0'.
     loongarch can be added. I did not run it.
   - poke_descriptor is x86-64 only. No other JIT reads poke descriptors.
     It is one subtest of three, thus '#if' and not a DENYLIST.

In the tree today.
Pre-existing bugs... pick me. pick me.

10. Blinding is successful, then the JIT fails, and the kernel goes back to
    the prog that is not blinded (CONFIG_BPF_JIT_ALWAYS_ON=n). Line info
    stays at the offsets of the blinded image. bpf_adj_linfo() does the
    same. The series removes one case: a failure in the middle of blinding
    does not leave the table half moved. bpf_patch_image_install() is now
    the only writer of the table, so the fix is small.

11. bpf_opt_remove_nops() does not look at aux->nospec. A jump that the
    verifier hard wires can have it. The wider rule of patch 5 adds one more
    shape: such a 'goto' over 'goto +0'. That matters only for CAP_BPF
    without CAP_PERFMON. It is one line in insn_is_nop().

12. A prog of one function is blinded after the verifier log is finalized.
    "insn N cannot be patched due to 16-bit range" is then not counted in
    log_true_size.
