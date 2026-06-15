Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304943B2FCD;
	Mon, 15 Jun 2026 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511012; cv=none; b=b/8ibPoNUdbR14HSwGZXSfjmStvAK3vNsqGx22/3W2TmrviS1PKUSzFE6/pu6jYt3FDAfa1uX8evu0w+IBMpy7FSk+tb9rjFOSexx00Rr+L2pwAbqTjEdN0FCv/LS4SNQ2exQZLmq7lH5FyAndWSxvoz+ZMZ7UI/NwQEiSZM+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511012; c=relaxed/simple;
	bh=FtLadxCZQfzBTe+Jo+TwLhq+4DJDTgykBuOI8WCR0mY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BKLYnSriJ3IUAVyzz5/tYeHWp71qnv0yhWYnlBF4R9bNDMCN5pp0rVj0ZwbFxjoZAH7k3rZJtIw4vKYYRdQOFPnaTB/uO0fwGM2CzQ8RaL0fhtqZcQ35ZeV/K/FNK0Opmxfhnh/kEWXIVpTspWNcTBIpqsPd4e0Q0xb2/RNGgtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=fO4rBH7H; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="fO4rBH7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=LYSjPaIeYxr/z3oJSVhQ452MYMiD1E3/i0FeKBM0jNg=; b=fO4rBH
	7H/dat0ZgHp8cnpUBCo3Hj80cmsiGTKrzD9CvKiyU0jILzfgg8bQP2KXhc3/HR/T
	m/6Qn2D8w0XO3u42xDlEQfhw8TjUaIu0nOYk82LblrDKMpPM7p5B/DHFYmAhx2vM
	1djaKBGRYqEK1RsLpTq0AaS/s8bZ8zFg5m1NE=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQC3y6BWsy9qKJVJAg--.52153S2;
	Mon, 15 Jun 2026 16:09:59 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next 0/2] bpf: Preserve pointer spill metadata during
 half-slot cleanup
Date: Mon, 15 Jun 2026 16:09:52 +0800
Message-Id: <20260615-f01-06-half-slot-pointer-spill-v1-0-47f1c18a8965@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFCzL2oC/yWNQQrDIBAAvxL23AW11UO/UnqIZm22iIprSyDk7
 7XtcRiY2UGoMQlcpx0avVm45AH6NEFY5/wg5GUwGGWcctpiVBqVw3VOESWVjrVw7tRQKqeEdPG
 Lcc4GezYwIrVR5O03uIGvETNtHe5/Iy//pNC/fTiOD9FfheuMAAAA
X-Change-ID: 20260615-f01-06-half-slot-pointer-spill-e4bd2665c532
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781511000; l=1642;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=FtLadxCZQfzBTe+Jo+TwLhq+4DJDTgykBuOI8WCR0mY=;
 b=Wjf6xYhg2ulLy9OscgbQccqVk7TUDm3/+GgUr57YCD2xa3+W8TlOf8OOe8DWtad+BjNTMhNjK
 WXk25VwpI4YDi97xS2kuayhaKMZDt+B74lJS8xZsdp70LoPvAjSwlT2
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQC3y6BWsy9qKJVJAg--.52153S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF17XrWfCF1UCry3ur15Jwb_yoW8Wry3pF
	ySg3Zaqr4kGF1IkF13Aa18GFy5CF1Ikw1jgF13tryUZ3s0q34UZF4kK3y3Zan09FykJw4r
	Kr4rXwn5uF15AFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0Ysj5UUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgETA2ovr8QHSwADsy

__clean_func_state() cleans stack liveness in 4-byte halves. When the high
half of a spilled register slot is dead but the low half remains live, it can
currently degrade the low half of any STACK_SPILL to raw stack bytes and clear
the saved spilled_ptr metadata.

That is safe for scalar spills, but not for non-scalar pointer spills. A later
partial 32-bit fill from the remaining live half can otherwise avoid the normal
non-scalar spill rejection.

Keep pointer spill provenance intact for that half-live case and add a verifier
regression test for the reported shape.

Validation:

- A raw `bpf(BPF_PROG_LOAD)` reproducer exercises the half-slot cleanup case by
  spilling `r1` as a pointer, executing `goto +0`, and then doing a 32-bit fill
  from `fp-4`.
- Unpatched `bpf-next` at 7bfb93e3475be9de894f1cecd3a727d3e1649b03:
  selftest FAIL as expected because the verifier accepts the partial
  pointer-spill fill.
- Patched with this series: PASS because the verifier rejects the same load at
  `r0 = *(u32 *)(r10 -4)` with `invalid size of register fill`.

---
Nuoqi Gui (2):
      bpf: Preserve pointer spill metadata during half-slot cleanup
      selftests/bpf: Cover half-slot cleanup of pointer spills

 kernel/bpf/states.c                                    | 13 +++++++------
 .../testing/selftests/bpf/progs/verifier_spill_fill.c  | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 6 deletions(-)
---
base-commit: 7bfb93e3475be9de894f1cecd3a727d3e1649b03
change-id: 20260615-f01-06-half-slot-pointer-spill-e4bd2665c532

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

