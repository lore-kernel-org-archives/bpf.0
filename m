Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794425992;
	b=3q3Z3FHqed6Qvre0bX/h7ei6xPvdIHljBtaO+JMdasHwHwJf1ePhkl7RWzhwCfcp1KFF
	 V2jvQ6slYc8yT2DHWqikj4UWQgsftLf3iTt+Ke0giRfEYy8cC7+0muE39TfjrH9eHZLhq
	 Ntbv784pExZPdI1kYXa0l6ORhO4c+rWbQkwPIF6hNcIkg2sftdu0Psc3fQN3+5sL5/5df
	 4/ApOmmbM9s7dOV481QFPc3+YiLeliT47ZUFtPK4ZX966wDTM8qoWUA+O78MFGJDMg/sG
	 BY+tSpRlRuXzmD+AErI/PcZiVku79rmiO/Kx10JzDCKmMSKRpCpiK/NJ6Ha/KITVR1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425992;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Td0ItVeZwbTzLmxf/12FHVAo66JNI+ERH37EJuCLhYg=;
	b=aYHgymL3LiLql8NHJQ1eLfj9M8/5PEaOfIuT7E5Rz47HoQyhpuxdjRakRBb11CWLLo8c
	 tce1pxphSG+k7POEZjC5oM/XsXrpyazc61qk+jgL4RZjP5Wy7+AG7KSUEf8ENhQo4C9zx
	 eCqMvv0gDYaUWsnrCZ6UigS98jrvTTvq1YkcafY/U8wWR59wUav8dDOiaJu+TLGWtgD9w
	 0KLRFcPYLC8S34FKkiZTrJsh6Z5RzeERynf0e4HrzEZvv5mipZqWIb28BVJj/zZEFDhEB
	 y21xerz2UkgC3BhsEtDWjhpyNJ36nfW1UY8wvKmp8h68i8aZUZNJL3L+M6SrzOB1V2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lX4hg/eR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A99606A33B;
	Wed, 11 Nov 2026 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lX4hg/eR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794425992;
	b=Jo3BoDv71M35CllZtxeduW/y/qBFwEa8dKWmEzSoL1z3BktSBkj4j7zpbmIiBCKQXDZI
	 lpqkUTR0W0z3x/k4Wp48YdlglNzcyrNJxacbMHd49pBPk1REoV3LpTC1heSuUKIIFXf8N
	 ie8yBwjHbnAM3BBtKH+tmQe/DR8ZYK0qqFnsQjMlgO6wB8FAL6YHjA6T7qOAZP3EtCwjo
	 y46VC/tcQazKH02T4qJluPZjOQ5qfPegq/iWBR1zOjPUxnMXK3KmuiBbJFArwXYnORZqD
	 k3N6J+0iRwhlRd8spriDSy4btAINmrlz6uttiHJVD4BuhoOGZLsRYbZ1qEAgYOaR+jg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794425992;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Td0ItVeZwbTzLmxf/12FHVAo66JNI+ERH37EJuCLhYg=;
	b=lG1vY3v2Q1YvTqVfq2Ngi4IvIWPb3iHijSpEpoIwtV1Kk8UzWJo2eSdxkLknMnjqi3hy
	 aibbyfl7dJ8pNE5AQM/JwgLgSArsJUfsZvqlx8VEvoB+mMFsPQ9KZ03d0AG1Zg968iKJM
	 VCEvDT2raq7YJqdIy3crx8iuu/G54cnE4IisKXvWZQsKRR7aVHjoX8ZCw/+k4OFh165m9
	 qgkxhckTUc6Y2MXesP/dfzxjtbdgJyl+4TwNnzy5E1roNStXUWkmLNxTNUd0xA4IRHyoa
	 EpuMDfoD2DXsWNDSmagQAOiB3Gw3Zy+O/aUV5BCYyEPneet+hPDAbo5ZIJmAmPRLe7g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 29DB01F00A0D;
	Wed, 11 Nov 2026 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425992;
	bh=Td0ItVeZwbTzLmxf/12FHVAo66JNI+ERH37EJuCLhYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lX4hg/eRyVKeOILm9gvx7Bif0XMHs5bNWNLoU63C4Miww+9DLSAzwcjgSdrhyebTg
	 7sI3DJXmC5Pnul13+9t7EcH63TkHEEgEP/T/4nEniicLUDuReCxiXrBfWJK5lEs8Rq
	 pYFYoQaUbsfIdizoKOkohw0A+IP80SxH487CMSz6FIM9tBf0mG0OiorqxwAGWzReaP
	 RzDJqvUyJw19+OppkhDGvMIUGH/aG22DqsrHLc85aKlXQ5HJzQL2UtgfZiSFGcaXBe
	 B+O8GJgxRZpQ3GVPOYRDJwT7vLnHjosZ/CLnNTr1FsS0ha7ckchS3cRJtBmOcb6Baw
	 rCgj+dNOt+TRA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A9CCA490C2;
	Wed, 11 Nov 2026 19:39:50 +0000 (UTC)
From: Mike Bazov via B4 Relay <devnull+mikeba.sentinelone.com@kernel.org>
Date: Wed, 11 Nov 2026 21:39:49 +0200
Subject: [PATCH bpf-next v2 3/5] bpf: Check recursion per task for programs
 on syscall tracepoints
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
Message-Id: <20261111-bpf-preempt-v2-r2-v2-3-9d8f6b952ad2@sentinelone.com>
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
In-Reply-To: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mike Bazov <mikeba@sentinelone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794425986; l=1799;
 i=mikeba@sentinelone.com; s=20261022; h=from:subject:message-id;
 bh=+dOmL4KrsoZoGHMSIZ+zYy2Dw+1c2bQCDaNaqZIz4eA=;
 b=ngIG6k9K+uC7fNwJvhNNFFAP1Zl9aFx8bASTNwTXbce+1J8lGwXGxG46cfCbaib1vgWx79Exj
 xE72nTL1eCtAN9dQwGBYhjy6qK9EFAWpDItR5KxcGI13NbnwahyXCNE
X-Developer-Key: i=mikeba@sentinelone.com; a=ed25519;
 pk=DBXcQ0qoCkgacRsRwT1JU7oOWpWSYuTyLiXMfNLcP+A=
X-Endpoint-Received: by B4 Relay for mikeba@sentinelone.com/20261022 with
 auth_id=1284
X-Original-From: Mike Bazov <mikeba@sentinelone.com>
Reply-To: mikeba@sentinelone.com
Content-Transfer-Encoding: 7bit

From: Mike Bazov <mikeba@sentinelone.com>

Since commit 57918341dd19 ("bpf: Add sleepable support for classic
tracepoint programs"), classic tracepoint programs on syscall
tracepoints run before perf disables preemption, through
trace_call_bpf_faultable() and bpf_prog_run_array_sleepable(). That
runner still checks recursion with the per-CPU counter, so a task
preempted inside such a program blocks every other task on the same
CPU, and their runs are dropped as recursion misses. A sleepable
program that faults keeps the counter raised for the whole sleep.

Use the per-task check from the previous patch. The runner publishes one
frame for the whole program array, so the program is recorded in it per
item and cleared before the next one.

Fixes: 57918341dd19 ("bpf: Add sleepable support for classic tracepoint programs")
Signed-off-by: Mike Bazov <mikeba@sentinelone.com>
---
 include/linux/bpf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 52e29b374b4a..649ff2950fd6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3549,9 +3549,9 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
 			continue;
 		}
 
-		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
+		if (unlikely(!bpf_prog_enter_recur_ctx(prog, &run_ctx.run_ctx))) {
 			bpf_prog_inc_misses_counter(prog);
-			bpf_prog_put_recursion_context(prog);
+			bpf_prog_exit_recur_ctx(prog, &run_ctx.run_ctx);
 			item++;
 			continue;
 		}
@@ -3565,7 +3565,7 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
 			ret &= run_prog(prog, ctx);
 		}
 
-		bpf_prog_put_recursion_context(prog);
+		bpf_prog_exit_recur_ctx(prog, &run_ctx.run_ctx);
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);

-- 
2.43.0


