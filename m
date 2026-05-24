Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113F1C8603;
	Sun, 24 May 2026 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779653099; cv=none; b=J7jsYgVQAtdpOd4UrdEwjHPlhWhBAEoylyoWrqNkhxEtQNSZTwJrPapW2thoW2OcW3PMRFdPNnPRI1Tf2Mu7/gaSpawSZ3+jw9g6QqZT2/FJ0OxqedRNZgx2V4PiNfKh36jCX3eVEOzy0qiZnZYK2CHM55RS5663SLAjthAtg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779653099; c=relaxed/simple;
	bh=fCKF3PPp+Jp8X+FAVNYY9GCecbsoC3bRkp5BL0rQWIY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bvzgoImWQH+P62AHj/c05TzmoVOphXrVpIlC46/UCU8BecfeSp2t0AMVSxJqzpFlRmuVzmKZsEDkyDsTutDFHGxQFHrXPUqPIMw6nGEkzHOxtvyJZ7bmH2XbvfuEuuOQwB2TKe0EpWKg5oyitFd9arccu0hgPG/eSYjycsLvSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=dSwkv62o; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="dSwkv62o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779653095; x=1780257895; i=deller@gmx.de;
	bh=YhYzGRBc7dh54OjUCQBmQmF1aYtokNFXAjZ4wYoD8zk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dSwkv62ortvXLLNsRSp2Uz6TxZhx3agH9G+bGbf8WxlHVsXnpFBsUGxn1e5HBEHI
	 6Y144CkAhEqbtEz2mjL0ihkejip/197j/AFPFnmgmwGKCCLlD9P8o1nyx19giMp0l
	 /dvWHcmTInL4Wwdj6GMfzOgmkc9bS5UPxv0W7TFb7SnESABJwgiYyIUvtvvKA1PSW
	 Pdzfn2Ey+mDzvhnpG308/bXvvefYrCh7wVHRtFoNJPaA8fQoyRGplfYi5db4skp77
	 4gx/kMjoFNofI0HnX5hUU/EPXvF7WyXwY4WYbboEk+fgY4dZN5lxltVG8WV+V0iwA
	 G6LXGy0An62qR0TBtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1xNcyR2alI-00wBI6; Sun, 24
 May 2026 22:04:55 +0200
Message-ID: <8666e3c5-25e6-48ff-9dd8-aa2662d4cda6@gmx.de>
Date: Sun, 24 May 2026 22:04:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bpf <bpf@vger.kernel.org>
Cc: linux-parisc <linux-parisc@vger.kernel.org>
From: Helge Deller <deller@gmx.de>
Subject: crash in bpf_check() on kernel-7.0.x
Autocrypt: addr=deller@gmx.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Reyj+qU7xXPCc4vQJFkFdgcaPvyu7MBXYTcceDCTjzkM8CmqZVp
 Q/Cs7a0/alFZ/Hwlhm6T6TYyrCY1VHmSDJQsVibwgfrnBAQJxCOFKIhhBK3lOH3IYR2ZKbB
 gE6ksg3ZGQhN4ZEo0jfLPPEABMTRqViHh/ZnBW01YCzyFiu9Q96U/OVvrSPfbhmYdZhRJfO
 oPHNmfIXDQVXmwN4cdbsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GxLGezStAq4=;qpBD56Uhp6OgkqlwZu12Sn+wtzL
 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
 2qT9Sw==

The 7.0 stable kernels crash when starting systemd on the 32-bit parisc architecture:

[   45.422328]       _______________________________
[   45.422328]      < Your System ate a SPARC! Gah! >
[   45.422328]       -------------------------------
[   45.422328]              \   ^__^
[   45.422328]                  (__)\       )\/\
[   45.422328]                   U  ||----w |
[   45.422328]                      ||     ||
[   45.424088] systemd (pid 1): Protection id trap (code 7)
[   45.425190] CPU: 0 UID: 0 PID: 1 Comm: systemd Tainted: G            E       7.0.10+ #3160 VOLUNTARY
[   45.426202] Hardware name: 9000/778/B160L
[   45.426667]
[   45.431345] IASQ: 00000000 00000000 IAOQ: 11151878 1115187c
[   45.431705]  IIR: baadf00d    ISR: 00000000  IOR: 11151878
[   45.432067]  CPU:        0   CR30: 12e5d7c0 CR31: 00000000
[   45.432499]  ORIG_R28: 00000000
[   45.432748]  IAOQ[0]: 0x11151878
[   45.433659]  IAOQ[1]: 0x1115187c
[   45.433917]  RP(r2): bpf_check+0x1bd0/0x3abc
[   45.434416] Backtrace:
[   45.435179]  [<10536ad8>] ktime_get_with_offset+0xcc/0x234
[   45.435866]  [<1063b8cc>] bpf_prog_load+0x720/0xcd0
[   45.436280]  [<1063dd18>] __sys_bpf+0xd44/0x277c
[   45.436590]  [<1063ffb0>] sys_bpf+0x30/0x8c
[   45.436879]  [<10416334>] syscall_exit+0x0/0x10
[   45.437241]
[   45.437575] CPU: 0 UID: 0 PID: 1 Comm: systemd Tainted: G            E       7.0.10+ #3160 VOLUNTARY
[   45.437748] Tainted: [E]=UNSIGNED_MODULE
[   45.437782] Hardware name: 9000/778/B160L
[   45.437909] Backtrace:
[   45.437927]  [<1041c878>] show_stack+0x54/0x78
[   45.437962]  [<10411b78>] dump_stack_lvl+0x80/0xc8
[   45.438000]  [<10411bdc>] dump_stack+0x1c/0x2c
[   45.438034]  [<1041c9c4>] die_if_kernel+0xf8/0x1b0
[   45.438067]  [<1041cf0c>] handle_interruption+0x490/0x93c
[   45.438159]  [<10536ad8>] ktime_get_with_offset+0xcc/0x234
[   45.438196]  [<1063b8cc>] bpf_prog_load+0x720/0xcd0
[   45.438228]  [<1063dd18>] __sys_bpf+0xd44/0x277c
[   45.438267]  [<1063ffb0>] sys_bpf+0x30/0x8c
[   45.438298]  [<10416334>] syscall_exit+0x0/0x10

My findings so far:
- Adding some printk() inside the bpf_check() function avoids the crashes, so it might be a timing issue.
- No crashes for the same kernel on 64-bit parisc.
- The 7.1-rc kernels don't crash either.
- I completely disabled the parisc JIT compiler -> still crashes.
- (Maybe unrelated:) CONFIG_TIME_NS is not set on the 32-bit parisc arch in 7.0, but it's set in 7.1.

Any idea what might trigger this crash, or which patch might be missing in 7.0-stable?

Helge
