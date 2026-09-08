Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877055D86B;
	Tue,  8 Sep 2026 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882390; cv=none; b=Ne/HT9bTKfJaw64epyvi5PjjkALdCVG6GKytVqluOmDf/XeOuAJ3SARO47CQqiM2W7VTAmPy8h0MQElkA93MR+w50Aw2deNjrz1kJ5qq2/61UL+HHsyi+SW4aJzjTY1ruP6M3M6kZHk1YJUYYMMA/nb5+W98faSp7SdwWXRR0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882390; c=relaxed/simple;
	bh=7qYYfjyLc3tn8rvvC+NAQfgXS4Fq6g//NqNTayfF6Po=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UtSptC4pREwx4a7tGV9a3eDKDrOXSlNxIDjdEIGHk+QdjDGp8+pUUgcAO4JPckjbAOzfZY7ZFVfMBleqpVu1uvDKeauoNiddVpITw83c69yU4+QWNcgm7uLrlb4vBCfJE8w87cNKJ0Q3lCz7DCU5EUIzniV0wSI/YhoFN/8YKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOuSoqWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOuSoqWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19761F00A3A;
	Tue,  8 Sep 2026 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788882389;
	bh=Kztwgkb4XTqQOeNq3XmEydkSmcGr+YU/Q1mfeqyJ2XQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iOuSoqWw7qP1Yc/L/V2+cOdZ+MANRMYM6PGoeDgP1FDhSg0a8zU61yQhHe+bkv766
	 Ilqn+T9ExMWwNOk+nzExpTBxaw8/zA9OyXKYkvRWtq0KbnDU/nq0sv+ri3N7Y0eBEF
	 ZHHjnUJA3zLbVzSZZaf4tTNZrNX7POGgWY/MIUYF9L8MyNdGEjgzHp1czviMIsyAVk
	 g13G43fgzkCEvbWLl9aCIoYpHSNwMdLNDI8shCjpzD8UuoWXNqQGeiGiCYhXQFrt7C
	 qy6NFbi/9RCf69zbGtel9SNg8bbuf1hLQArT8FsYXuM4CV2MWcKbIptG/kqDqkkSgn
	 VFbP8HdCdtTCA==
Content-Type: multipart/mixed; boundary="===============2347235133467270577=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e66e3d4c2b5ac1bafc96110f70eb902b88ff47da341ed847a46d11ffa01239ff@mail.kernel.org>
In-Reply-To: <20260908065529.901593-2-tweek@google.com>
References: <20260908065529.901593-2-tweek@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify program FD after non-autoload programs in lskel
From: bot+bpf-ci@kernel.org
To: tweek@google.com,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org,tweek@google.com,kpsingh@kernel.org,leon.hwang@linux.dev,emil@etsalapatis.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  8 Sep 2026 15:46:27 +0000 (UTC)

--===============2347235133467270577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> In test_global_percpu_data.c, dump_percpu_data is defined after two
> non-autoload SEC("?kprobe") programs (verifier_strncmp and
> verifier_snprintf). Verify in test_global_percpu_data_lskel() that
> lskel->progs.dump_percpu_data.prog_fd is properly populated (> 0) when
> loaded via the light skeleton.
>
> Fixes: 4c9241bd731a ("selftests/bpf: Add tests to verify global percpu data")
> Fixes: 1ed2294b31fc ("selftests/bpf: Test verifier log for global percpu data")

The existing Fixes tags point to commits 4c9241bd731a and 1ed2294b31fc,
but the specific test scenario being verified here (dump_percpu_data
program appearing after non-autoload programs) was only fully introduced
by commit 15945d02c6e1.

While the earlier commits laid groundwork (4c9241bd731a added
test_global_percpu_data_lskel(), 1ed2294b31fc added non-autoload
programs), the dump_percpu_data program itself was added in 15945d02c6e1.

Would it be more accurate to use:

  Fixes: 15945d02c6e1 ("selftests/bpf: Verify bpf_iter for global percpu data")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34245369055
--===============2347235133467270577==--
