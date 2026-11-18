Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016154;
	b=l9LmD1E+OdNW3G5cOs1W8KGkzyht30YWXu5rkHXGt3uQzeWsXNb2sG4cpcVfmVoYazCV
	 2CDqK+vP4hQCTm41EIC55CZK2XPMmevA5hbH0qFMCCcPz2G0Yf4lg7BRAppNR7MYfCwML
	 +OxyOyg85NIoRxLMFSkLUwht6mKdotitVRrlzdzeWqRNIcrdpTCKd8VnJ+663kRRji2Ra
	 eBGk69CphjWYneF6IT6wv1zVxGoNMdh5LM8VPkbVxBsBN5G2L22HdSWO5EixYZOUhkeaf
	 Z85XyQY7zW/MhwMazTm/7Sdf6HdwoAjYe4BsMDSVD6UntXPWyfjKQeXDA1oIV5EVWQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3Qmc9lNd7iPlnbZyEjNTU1GhBxli118PZ9egywv3GAI=;
	b=CpqdmB4Fghey9lrYdr7qvoU9sqb6nknF1gwMJL/G6pktOD9tEQj6EuTbRSQ6679Ar5wz
	 Z56edMM5KX3X3Rh7f55fOc3SRrx/xB4Hfd86AE6ryGMKalO+8g7jjTkutIIUjtDC/7o5D
	 UZjmMvtutrtaj5R/gptIrlwaAUmlGy4K5gqrfmWfu8eB6+iBVppJietohcZU0URUzyZ9t
	 hRIjPwGcOPPb8JZE2hLulYOFSUaWMnMnwv3n8C1lC9AUJ05sHXeLFk6BBbrA9HKQHOoaW
	 2ivstxC4r+f9YRYxk3oYSAraW4foGgNowacGAA+texc8lBTFn/4YwDswaw2JXjJwLgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yP0QupT4;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC6606A339
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 15:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EDC6606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yP0QupT4
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3ada6c66964so211863a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 07:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795016153; x=1795620953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Qmc9lNd7iPlnbZyEjNTU1GhBxli118PZ9egywv3GAI=;
        b=yP0QupT4N4LRNps0kf45U5ceMoPgEFIHrfAFIu7l4xEwo7gzDxBRz6j8xgTDi+Z1xE
         UjeD87JhTWVaVo1jlCVyg6DzWgKb4HLsk1Hn5IRxv14EElD8WlMPu+0atQIWlnsRxAVf
         yxDJ4SONkjlwP+gW0hCK9tWtsDh2ntiXBSr5sottqEheRBNqpjgrPqlvqnu7MpURWfEZ
         Nm0EPeI2628kd7lwxk1W847ia/xVHg3+FeFj+AlNUPuRdwOVozlyVh5d0g9E7qz0TZSQ
         bjKXkWYCOUVTSj24IP5tHeBA7Z33kJoXzeBPphlVPjK1QRQNeyRnYs4BsbEYuthzATT+
         a98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795016153; x=1795620953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Qmc9lNd7iPlnbZyEjNTU1GhBxli118PZ9egywv3GAI=;
        b=EAZ/C/Gcqq1JU7jingOKDO/ze8fXwTZ299XgIs+/Q92lgp/qgbpPckntAd4jYQCh6o
         dgZZk9wEypJCVqJ4niGT5BSdLVsNZbWQjJxMsKhF7rR6SQ7mnp4pVvOzm9cCo415Hzmf
         leMvCj/nFfookox+JZPzfQkCnyx8drSRRZj1Nnf7A5eLsmBXIybSaGsQCOHv59jHqweF
         1XfdNkhsO5TmCfoAGayiQ2FGVPvkbf1vj+NRZKEjj5Gobo2QRhBG94vg//pwF02M12Kx
         wrYE5FvuW3L78Y0C1o1G6pUxfZ6iKQhw8RSnXtE7DfChBSd6KZ31Uk8GF4QX/IeVgeAd
         zP0Q==
X-Gm-Message-State: APuU4Z9QpxY1WaeeTtiTtf+HZXjWq1wfu3NL7ITl33HetjMnSQncREnD
	GD4yXhPf9Gug+esCNafyrk79b/o972uOSbhD4Z/cnxoQhLacaHpcjDXF4jqij04vnrpHPg==
X-Gm-Gg: AZFdTZfi8YLoKhykdeDi2ramcAeEch+yEPxlrQomwIvheD95XgG8O/rnHCPncIFpW1/
	L3HAiK/yjdciLamzhlgjUzgkraQuLF43QHP0LTZw4v/tu5Y8+6e0jz3wsr1iJgA6lzm/39K3MNp
	UiTYe/3Lsb/9v7pNtN6rmt7NuYzIBpLTE+0kSS8IFqPiz6T8zTBvX5y2n0fMFuv2ofDyUZcc87b
	UEQmJtxYootNoRMQa99j8r5M1QwOEjZskzLKKb/0kI+47RMI2aa+v08G9eLIoQeRhhUFE2W51kR
	hbNfHKXckBVJQzxhTRk3vDdgN8XnVUKvYruNH7+ia+o2gTnagPX0GktzE/MgqhnLPcoqxfFa7v9
	/NTFqJg6zZz76+1xM1Npwg2r+k+h0Khwp9w77/GJk58VRKKFxryz5wq0PqMRBg2PBbK5GtZIi/R
	pEHo6sId74PJwwZb1z3vziT7KTb/TAfMkaJvtXJEgoJdLNtcpM4kWy45OsY7pJ30bnDOvDtD1/2
	Ens2TGkd5PnTse/XYJCUpyf9sgEnmmcNe4AQF6DI49NPA0Ca557Biq9uK//LpfQ90U8LLJdtfmH
	h4SVOAob/Nf/TZ7AuAIDtaZUnDKmwrx6a3dH1x5M6FA15Qw=
X-Received: by 2002:a17:90b:4f8d:b0:3a4:6e84:e7f6 with SMTP id 98e67ed59e1d1-3b3d064130amr3334575a91.5.1795016152908;
        Wed, 18 Nov 2026 07:35:52 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6214cd8sm15952755ad.44.2026.11.18.07.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:35:52 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	edumazet@kernel.org,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2] net: sock_reuseport: check program type on the migration path
Date: Wed, 18 Nov 2026 23:35:41 +0800
Message-ID: <20261118153541.172499-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
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

A BPF_PROG_TYPE_SOCKET_FILTER program can be loaded with
expected_attach_type set to BPF_SK_REUSEPORT_SELECT_OR_MIGRATE and
attached to a SO_REUSEPORT TCP group.  Closing a listener that still
has queued children then runs it with a struct sk_reuseport_kern
context even though it was verified against struct sk_buff, which
KASAN reports as a stack-out-of-bounds in ___bpf_prog_run().
Reaching this without CAP_BPF requires
kernel.unprivileged_bpf_disabled=0; with
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y, the Kconfig default, the sysctl
starts at 2.

reuseport_migrate_sock() decides from prog->expected_attach_type
alone, a field user space sets that does not identify the program
type.  Require BPF_PROG_TYPE_SK_REUSEPORT there and in
reuseport_stop_listen_sock(); socket filters still work as
selectors, so the selection path is unchanged.

Fixes: d5e4ddaeb6ab ("bpf: Support socket migration by eBPF.")
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
Changes in v2:
- Fix the author identity in From: and Signed-off-by:.
- Mention the kernel.unprivileged_bpf_disabled dependency.

v1: https://lore.kernel.org/all/20261115152408.48205-1-shlomojune6@gmail.com/

 net/core/sock_reuseport.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index fccbdd0430b059..9ab76697a794fc 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -460,6 +460,18 @@ void reuseport_detach_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(reuseport_detach_sock);
 
+/*
+ * Only a BPF_PROG_TYPE_SK_REUSEPORT program is verified against
+ * struct sk_reuseport_kern, which is the context bpf_run_sk_reuseport()
+ * passes to it.  expected_attach_type is set by user space and does not
+ * identify the program type.
+ */
+static bool reuseport_is_migration_prog(const struct bpf_prog *prog)
+{
+	return prog && prog->type == BPF_PROG_TYPE_SK_REUSEPORT &&
+	       prog->expected_attach_type == BPF_SK_REUSEPORT_SELECT_OR_MIGRATE;
+}
+
 void reuseport_stop_listen_sock(struct sock *sk)
 {
 	if (sk->sk_protocol == IPPROTO_TCP) {
@@ -474,7 +486,7 @@ void reuseport_stop_listen_sock(struct sock *sk)
 						 lockdep_is_held(&reuseport_lock));
 
 		if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_migrate_req) ||
-		    (prog && prog->expected_attach_type == BPF_SK_REUSEPORT_SELECT_OR_MIGRATE)) {
+		    reuseport_is_migration_prog(prog)) {
 			/* Migration capable, move sk from the listening section
 			 * to the closed section.
 			 */
@@ -644,7 +656,7 @@ struct sock *reuseport_migrate_sock(struct sock *sk,
 
 	hash = migrating_sk->sk_hash;
 	prog = rcu_dereference(reuse->prog);
-	if (!prog || prog->expected_attach_type != BPF_SK_REUSEPORT_SELECT_OR_MIGRATE) {
+	if (!reuseport_is_migration_prog(prog)) {
 		if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_migrate_req))
 			goto select_by_hash;
 		goto failure;
-- 
2.43.0
