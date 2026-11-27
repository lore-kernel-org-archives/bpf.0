Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774452;
	b=GBuM0D06uWKLszqQr03ZBIn2AHbv5/gocrklhfI1nQCvY8kK4QAzkbRnCH0F5qHm6OCX
	 ogc2j8JdVFsCKWDHuByKzxcgatJBRbTdDYGsjN/z1h/Dd7EBf3CKi2N1Id1BlfxZnyjoG
	 ixeF0BaDW8GUcgxbyw4511uwJOFgJdpWDeVG4ZcMvcF4mpaB3jcO8mkSHZ0LHjtf2RYUh
	 VK/vtbxWpMx4nzWbVkFqMylEqCH4n0QXHTwQDfsuIeqGKE0cMnA2dEeWd9I5TxCz5fOxr
	 r0dGSnlSsa3HjoVhwefILVl3jNOlACITOJQGLvemqcJI0ETQQalPphW3WY67XU/wlGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=pnSZi82mVfZLS6PwIZVcWPzE7AlvW48La+q7lJF7NRc=;
	b=lp6zERjXdVALcbxAWxPi8sYbWn8M4R59aLO0FZyazSFGNLSKU7mYdOQdt6DTlZZFq6Rj
	 Khdd0Rv3/PAW7K01aNTQQqYC5FXKUxFw6MWQtFGm6yfrEBRuy5QbYn+/6D64UowE5LKoj
	 CQAKDOiJ29BudMamS4mSTB86umqrzEh1BivwT5fCfWvZDAeTBA0iQ4f0wLRxuhT1pf1Ph
	 8zzaZtOXg1vm7eJZExviXyd1B8MvRYOpMCHClN459lORLIcLlqgqPvpNaofWXlARkeBv4
	 Rfjm5yDQy2Snbz511hujMlKbRQaJjI5Kr1Ir61oJg4NFyc+xyf9X+Wbz15D6PBOcZgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDGzarso;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BE606A683
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F0BE606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDGzarso
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so1960735a12.3
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 02:14:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795774450; cv=none;
        d=google.com; s=arc-20260327;
        b=TsMlBLRwE73/IHcEvCtca3atvNvvD7pEWM01OEvN+NaIEFSEiLo0MI/dHzc39hTkgP
         mYs7sV42cX2WIbk3GMMD2i9igh3IOLwaZa8S/di6WqQqW1TKrrqbwO/l59lFqlg5N6Mb
         FbotfsHkFR/eSM6rOjoHyzfvAAEX32VKj5yDLu6+Z4U5X8NG/PzgxW4zmn06r1iacWQ7
         zAjT71ECI60GZv5l1MBkXK6NnkekQPxNxK8KNOkRCikh3XBmOvrETTZ9lMlWdgeKpsJl
         XlCZGpoLKV9++GK0Fm2qw70aZkCwhCwgXNtyGXhCy/2IGNoO4EmkYbz88u3d9MX9e2I5
         8vTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pnSZi82mVfZLS6PwIZVcWPzE7AlvW48La+q7lJF7NRc=;
        fh=4/pdzE7RJVsxRhciQE4A7C5Lve+yuR3C3Hdg+m6NdrA=;
        b=JJBHGHweDc6cc0Ob8f/JFRQFWHg/rOQ4tAgPfVHQuplp3aDcYj1Pp/PkEk3tPUxd9h
         8Q2tn76yktgN7EDg29V54fLSl1qAajrEIdcwF5YKWXtk2m4WIBKjKBIHaSqD7Qd1aesk
         HFp5VDchpZDSxy8jjolLbH4a+c57RqyFNV1bxhhQpRcw0IZhXUx/QXaSwyzMySrjkQi3
         dmDGU50XMaHgtSGZJPdWhGsfINyzr8po6xsdofJL7uaQsyqXJHibWb/PGJ66y7MFFVdE
         bz6Y7MSYRo8Yh9aNklePQh7HZGpm+IXYKlLcmOlLXN9dX/2Ly+AEZjw6x5ogFw7/xwc3
         6BCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795774450; x=1796379250; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pnSZi82mVfZLS6PwIZVcWPzE7AlvW48La+q7lJF7NRc=;
        b=YDGzarsoRdrYESd0WQH9jBHguYTwQ4MWdevK+E8KmC2uyYZLyscJgJwBjwonhC0NwT
         Bpl0R8s2k8kM3FuRv9FJf/wNwnI4Fc8/M8oqwnbMB+SuPWfh5FQpVSPenWXXWhy0LSkG
         sihB80deO7zB26y3FM3Qxo63SaGHV4Hlk0xud2yxHvlJcFdpP2r7KfcKkQcS7J5mMOIk
         yNq+7yigz9q0FaWoAyhrYX8dVr28Zsxpht995AvRZ0JNonpCR15863AMxYKEzaVj9BIN
         ZE+9pctjIYTqfK5r0M9n6Op5Mo20Hpx0XYCb1SgrrnlTiDwGGAuSqSE2STS7RkRnUD6U
         JwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774450; x=1796379250;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pnSZi82mVfZLS6PwIZVcWPzE7AlvW48La+q7lJF7NRc=;
        b=a8HZhO+6iwOVCHY552jen3U0Zz0OnLY25B7Uxk9naFVyQ7L/tVcl2k4DIx3A7juTwe
         fn6+b0Iya36/56pqZBBGjtfAtaEoDBcaI8n5+3bkf8d6bsMcGVyvMBLjf51QHZrEfl0m
         n0gp1S4mEH8CX5PJVFzZAtNkjdDQsDMAtjQfua5Y/h6iXyhvIITwGd/rNP0YYQnkyJyD
         D1ijffC5SvTPp5dZ0iTKF7AuMLTw0fUavTIBxcqGeBAmED9g1IPv67DWhiDzExxrpMoZ
         P6HgB3toGRjgGea4yADzvB+U6y+sgt/Xehvi0mU9Iz2Y5J1Ku8NC9veu69a1zfxaQ+ZK
         NwZQ==
X-Gm-Message-State: APuU4Z/7OBircyTH1XKcygcaQ19Awd2om3SiH2OtUc2TuGbvhjkfruKv
	ItK5YJERGI6SgxkKBfqc7m2w7Yt6tV1XaTOtmogbRaLnK3XsEcKhX2ewtI5R3Qs4tjPQsozegJn
	NUMTEI8ughnVnyNG7a+fed/K45IIG0CinrCp0
X-Gm-Gg: AZFdTZdarPriYXpm/d9179FxKXM36uT+CfjAinppzITLbnK2/qxBLZtwZEbuamSoki/
	vCRWOn2YphI6lVuxjOIwXaq2AxkZNB8LBI6RauQ8FrmpKZoGNflniYOTdEQ2k+AscatffuXFjVs
	xR68DSS+SdMo1iSFAu6i/ki4FDuTxqf3y15n17EHB1WFDddd00v111STmGtL2g86/nmsKYAzcgh
	zyH0o6z8plsjG4pNtSReoZirzYoxpA8FkfEAAnUlx5aUGJ28OF5KNJWm5LxnfG4l6NkmXvI/k4l
	/UNvmxhWefZs5NqGKolSgnvkIN/7k6ttuh6I4RTzCfEO486Hc8z8pWYjFoiC1Uq35KSWUlAoYyJ
	N3ybw8viVl9krelQhDhlwBE8dYSKtRvWAbDazXOeF31HckNrIwbUTLLkpY1mVrc0wfoFlbf/TYJ
	dO2K6b5el0dJwfLZ/x
X-Received: by 2002:a05:6402:44d2:b0:6b4:5d8c:95e2 with SMTP id
 4fb4d7f45d1cf-6ba37c7a0dfmr13780450a12.4.1795774450046; Fri, 27 Nov 2026
 02:14:10 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Abhishek Khade <abhishekkhade69@gmail.com>
Date: Fri, 27 Nov 2026 15:43:32 +0530
X-Gm-Features: Aa3M54oFJndZgHbtbGYTQ8JLkfWXcGRfcl4DQYm07uiwGxgi46GejzDgXxTGmzU
Message-ID: <CANspbQrVUG8h5ZWBW6croG=+VnDoseeJvPwid=gYazA4aKRjOQ@mail.gmail.com>
Subject: [RFC] bpf: Is an open-coded bpf_iter_mount kfunc wanted?
To: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

Before writing any code, I wanted to check if there is interest in an
open-coded BPF iterator for struct mnt_namespace mounts
(bpf_iter_mount_{new,next,destroy}).

I tested doing this without a kfunc in a BPF program first:
- Using bpf_probe_read_kernel() + bpf_for(), a BPF program can walk
  ns->mounts (rb_node) and read scalar fields like mnt_id and
  mnt_flags, though without namespace_sem protection.
- However, pointers obtained via bpf_probe_read_kernel() become
  untrusted scalars, so the verifier rejects passing them to VFS kfuncs
  such as bpf_path_d_path() or bpf_get_dentry_xattr().

If an open-coded sleepable iterator (taking namespace_sem during step
lookup and returning a trusted struct vfsmount * or struct path) would
be useful for BPF LSM / tracing use cases, I would be happy to work on
an RFC patch and selftests. If bpf_probe_read_kernel() or userspace
listmount() is preferred instead, please let me know.

Thanks,
Abhishek Khade
