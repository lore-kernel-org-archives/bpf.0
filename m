Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792641375;
	b=dzVhrEqK0LTQDtC2jYW+XMAowmA0zRZVG+oitW53XISVQEz807WH400VLbiaEaOTnY7A
	 +HxtJ7x8+xhv+cT/XaYMLkNlSJxjoW18kvqUJYiVKqWtNjJW6cNiZ7mD82s6UPdesEPTh
	 o7WUnj+WBHd5kaEbN1xl30MtS4zQPXEmel6/HOhUOx+qOJ6HDzrXhWaXdkops+DqjsXrJ
	 6icumUTtvqoC8ryl/YZQssvZFjp+0vZJSaW8zcK2hIh9drdxVc0ES1QQcOiBqtSqmS7nM
	 Ou5shctto6X6ZAc4I0Z1FGNjMEAmK7Y/HYh01Hz4I4BM3DnDX9eAiYCO0MkbyjLI9Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641375;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=arJS5zNxUZ/NsGOvG25bBRIXPW4pIJreaSXkDHOo//Y=;
	b=LOnuAvT2NIL04oFfc2eZ4fcN1zMTamslqzwHxpm0ZzCAtjbpRNFZStgrPIUmTtRb7JHv
	 57oTRsmVm4BtZOt5IPIV1H+i0mwJ2yYCUbItptuf04DY8PuaHRemKWRQKLdKaA7EJeM1J
	 PDfdZzLNQNBENasNLjNINm7DyVm+vr5fY6Dz6QxGmMrnsxuwW2AIWdJgSQMy8PJpayxJt
	 Rev2JXmNLgX0SSB8d0+d1qUt5oCTVKunIvx/vjYbb9olNK4syILjKh8oPWioNHGhde3fV
	 kRWjEATP+yyz/KC8p6FTUX+IPIywNO/OjVu+Ein36qPtEGgPRlG8w0qG4PgrbDM+KLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LeQUsW40;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FiEQZqdn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56478606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 03:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56478606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LeQUsW40;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FiEQZqdn
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M3jQng2093446
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 03:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=arJS5zNxUZ/NsGOvG25bBRIXPW4pIJreaSX
	kDHOo//Y=; b=LeQUsW40ies3oRJ6NXI5D45tXsY8K8JK+TzsTv+jloVMPQ3qzkc
	u711Sd+tNWvFJFgvP9yCrZj/jA89v5B/1MVk4fKqmTBVbq738WZnF7UMSuP7KjBK
	eXKGG74ilVaQ/lkdpNxJyEQ1TnoNTzPhqw+A/HwqxSSYksaj5ITK8tPzB+z2tOg+
	mvbAeZj0uVw73fMr4jzFLCKb3ZyFktXd7P3tATriigQrNRr2nL7g6xPR4BelDw/9
	Nt9Az2vP65mqRV1tKzVa5ZqI+GQyvhyQ+cqEKPT6EVI5ssPQjJGJXsTJjivC5VTN
	S8e/HM1wsP6bGC9Cs+vQ4CtlfF5NjDZQCRA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a8jp6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 03:56:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad3fc547bfso1292991a91.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 20:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792641374; x=1793246174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=arJS5zNxUZ/NsGOvG25bBRIXPW4pIJreaSXkDHOo//Y=;
        b=FiEQZqdnLY8Mc6vN3JBfnRCPESuT4rgZyMh9ZQZTIpkxSR7GmvwPndOAM/U/ec+tDF
         v/ON8vfBr5/gskK6GFIWSrFXSHv32EGxeKTt4WLTwB91kVHQj5EDV1IKuu+dwnv+KM+A
         Jl7Vj3h7qSWzEOaEQgMZTFgu0BtcK2xk9/O6LJPANhj+U3d9UT4cQSJ37dQkGLwyfosc
         qwXkGhGEO1F1YMgUssmjDJSqs2Vs34wSEaOasXkNyOW6vJmnvJ+MvDTArfZZu9QAnV60
         LZcw418Egsy49mWbJ4qCZgf7G+vwmXF7skWxmFdv43/Pke7MjQylpn+fKHyred/gG41D
         k5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792641374; x=1793246174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=arJS5zNxUZ/NsGOvG25bBRIXPW4pIJreaSXkDHOo//Y=;
        b=EQCqMtdMbQlGLSm4qQiHmGREcpfuinlS9SHaBxXc4ppfvwaFcICBtu/XSypug/0TK5
         MtJexYxFS9PlTjuXzxS4kSeujkCgzirSBNSoYBnop9uoCZYjE3A7DPKr6+B57J4JUX5c
         ExIDkzPfqd17kNNFOsbYjBFSweGrA7H/ryhHMDpsxLmbJRy5BdVN9+G2KLinLEDfUKhk
         WvUmsayFHxvTjl0Gc+XQFUDWWm/s+RVrDl5RMMprnAB/HqNQqiElXiipsJz2X0lCldt3
         gT3E0GX8LJ10l2SociX0UqqoLoiwZqufGRSC4HhHRBUu3Elaeo/GsilAOPdbBqNQNbQS
         qWmg==
X-Forwarded-Encrypted: i=1; AKwUvBzJhWvNqQhZjVj78EncmU8yPZImBX6rrHP5+MN3nnYxnx714DL0FEKELt+5FbJ0moQEli4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJnYHn/Q1guaXrYUWJsruStSdC2UeGdohNiLBQgjW3cwT/0Y7g
	hZYGIFjUFixQU46tofy1jvpy+sTKghXUSNvUJmz3wiwbfU8RhZZxMpsHWx+elNZIvJ+CUJ28Zfs
	fJSAYru6NNkcTspGpnzAneQomjW15MfzzJWBMLGWh0L3av/Af5pQO5Wfonly5bsM3yw==
X-Gm-Gg: AYBFou2VzLnTdpcGQqaf7VFRvs289PDXxH6GN9pFjC1KOBdr03iRVwwjZXxt2NxPsF0
	uoTsQgWmgM+ART3LJjDOPSxTio0YGbe1RS6rQLw9rtDRVvWsiwpLSFP4sgYbiIS8wlzNb8nXcd8
	JOeSLDQk0gbkfGsAcy78fvtrXIv3gVPS1C7T1U75LFX5MkiIHI0eyQpm7c5nDL5izvShOFoS1Gq
	ZEEHIDa1UJ2IvpQOEik1Y1U2WOvBw2snd/ei/ohkv2DFCS+SiLI4wwEMkEx4co9yGBo8xSsC4gC
	ku2cWcvzuFcfaTxnZdb8ewWHxZSaZBortD9xsTrka4zIBbimUERO9QRJv9CrnJASqgpWtdmKmEz
	35Jn2VkKcxtxa6gpr25XXFhBhnXnyL0gvIDptE+MVhgIISsSPey1OEMJqKCO2b/NKwyzdhSeSwg
	U/fCJork/tsBRGvyFXvJBTL2o5V4LvtRSjvtSMNQ==
X-Received: by 2002:a17:90b:3b90:b0:3ac:8527:3fc5 with SMTP id 98e67ed59e1d1-3ad86afbde1mr3512808a91.3.1792641373549;
        Wed, 21 Oct 2026 20:56:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3b90:b0:3ac:8527:3fc5 with SMTP id 98e67ed59e1d1-3ad86afbde1mr3512795a91.3.1792641372929;
        Wed, 21 Oct 2026 20:56:12 -0700 (PDT)
Received: from ip-172-31-25-255.us-west-2.compute.internal (ec2-35-83-207-173.us-west-2.compute.amazonaws.com. [35.83.207.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad82f10c0asm3577100a91.0.2026.10.21.20.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 20:56:12 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, bpf@vger.kernel.org
Subject: [PATCH] dutil: Split the objcopy command into words in exec_objcopy()
Date: Thu, 22 Oct 2026 03:56:04 +0000
Message-ID: <20261022035604.3183589-1-ricardo.salveti@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=JudkP84C c=1 sm=1 tr=0 ts=6ad9895e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=P2/bgbqRawb6I1+7fxbs5g==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=UMD6BtbPmZM_AR24lCYA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: VxHCURZv037fMIjb5VqKgygeFCQBUkYr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAxNSBTYWx0ZWRfX5pG3/G93WMtL
 RuZCB7RtwW4xHDP+LeFpIcvnrf720EAQ95fZ9dLkQh1zADon9jABOROg1hYjbYsIQVJt89o+Yjt
 AQdxYX+0JSgoKJI0w17jL1v1w8NPJF8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAxNSBTYWx0ZWRfXxhzXUOJxX80F
 vhmS8ebK5Q/xKms75C+dB5pN4G1hj1ty2hJCagsdamrD3U3qqMyMlEO1aia9+0bmTRRXL/675kt
 V1Q7ebFP25F27pMbi/vZysgrsSb8e8qdmYanxfgPWXzvyA3twgYTWk6kj6JZbG7lZWbnZTgj3Oo
 YoRVukoquGDX9S8WfuplLoqGO9jTIvh1R+ohb2zZpeuIuKe6QUuTghPB2oZwImJPyLvhbAHF4Ow
 goCeo4txcT4F40NlKpKc+ZVzzzBmuFTBr1HuQuG9lVLJS/tZ7i2+DrDP8T+RSTdmzJ36BHnrE8Q
 ZMcn4I3ALRBybfLmKgr9BQHRPM6zfY7hVynNRSkDRCC47FbzsVRZdaWI6Ch7Ze8JJeaWRmDJcBb
 +hU8VlupJ56wP3N4b2qJpWF6TeG0eWXtCncF684uYO4j6XJzoedb46Uk0SZaH3LpMVbCpnayIOo
 2Xu9yar44eI+Nt5IpWQ==
X-Proofpoint-GUID: VxHCURZv037fMIjb5VqKgygeFCQBUkYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220015

pahole 1.31 ran objcopy through system(), so LLVM_OBJCOPY was a command
line that could carry options, like the $(OBJCOPY) make variable the
kernel build sets it from. Since the switch to exec_objcopy() the whole
value of LLVM_OBJCOPY or OBJCOPY is passed to posix_spawnp() as the
program name, so a value such as "objcopy --some-option", or one with a
trailing blank, fails with ENOENT.

Kernel builds up to v6.19, including the LTS branches, run
LLVM_OBJCOPY="${OBJCOPY}" pahole -J from link-vmlinux.sh and use
${OBJCOPY} unquoted for their own objcopy calls in the same script, so
an OBJCOPY that works for the rest of the build now stops the link with:

  btf_encoder__write_elf: failed to add .BTF section to '.tmp_vmlinux1'

This breaks OpenEmbedded kernel builds, where OBJCOPY carries the
machine's objcopy options and ends with a blank when there are none.

Split the command on blanks, like the shell's word splitting did with
system(), for OBJCOPY as well. Quotes are not interpreted, so a path
containing blanks can no longer be used, either quoted as with system()
or as is as with v1.32. Name the file as both input and output, so that
a stray word in the command makes objcopy fail instead of being taken
as its input file and replacing the target.

Extend btf_write_elf.sh to check that options in LLVM_OBJCOPY reach
objcopy.

Fixes: 6789ef8a16d5 ("btf_encoder: Fall back to objcopy when llvm-objcopy is not available")
Assisted-by: Claude Code:claude-opus-5-5
Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 dutil.c                | 55 +++++++++++++++++++++++++++++++++---------
 tests/btf_write_elf.sh | 34 ++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/dutil.c b/dutil.c
index 38101f1..d333d41 100644
--- a/dutil.c
+++ b/dutil.c
@@ -248,15 +248,43 @@ int exec_objcopy(const char *objcopy, const char *add_section,
 	struct sigaction ign, old_int, old_quit;
 	posix_spawnattr_t attr;
 	sigset_t child_default;
+	char *cmd, *word, *saveptr, **argv;
+	int argc = 0;
 	pid_t pid;
 	int rc;
 
-	char *argv[] = {
-		(char *)objcopy,
-		"--add-section", (char *)add_section,
-		"--", (char *)filename,
-		NULL
-	};
+	/*
+	 * objcopy may come from $LLVM_OBJCOPY or $OBJCOPY, which the kernel
+	 * build sets from its $(OBJCOPY) make variable, a command line that
+	 * can carry options, so split it into words on blanks, as the shell
+	 * did with system(), but without interpreting quotes or escapes.
+	 * A string of n characters has at most (n + 1) / 2 words.
+	 */
+	cmd = strdup(objcopy);
+	argv = calloc((strlen(objcopy) + 1) / 2 + 6, sizeof(*argv));
+	if (cmd == NULL || argv == NULL) {
+		rc = -1;
+		goto out_free;
+	}
+
+	for (word = strtok_r(cmd, " \t\n", &saveptr); word != NULL;
+	     word = strtok_r(NULL, " \t\n", &saveptr))
+		argv[argc++] = word;
+
+	if (argc == 0) {
+		rc = -ENOENT;
+		goto out_free;
+	}
+
+	argv[argc++] = "--add-section";
+	argv[argc++] = (char *)add_section;
+	/*
+	 * Name the output file too, so that a stray word in the command
+	 * makes objcopy fail instead of becoming its input file.
+	 */
+	argv[argc++] = "--";
+	argv[argc++] = (char *)filename;
+	argv[argc++] = (char *)filename;
 
 	/* Ignore SIGINT/SIGQUIT in parent while waiting, per POSIX system() */
 	ign.sa_handler = SIG_IGN;
@@ -278,14 +306,15 @@ int exec_objcopy(const char *objcopy, const char *add_section,
 	posix_spawnattr_setflags(&attr,
 				 POSIX_SPAWN_SETSIGDEF | POSIX_SPAWN_SETSIGMASK);
 
-	rc = posix_spawnp(&pid, objcopy, NULL, &attr, argv, environ);
+	rc = posix_spawnp(&pid, argv[0], NULL, &attr, argv, environ);
 	posix_spawnattr_destroy(&attr);
 
 	if (rc != 0) {
 		sigaction(SIGINT, &old_int, NULL);
 		sigaction(SIGQUIT, &old_quit, NULL);
 		pthread_sigmask(SIG_SETMASK, &orig, NULL);
-		return rc == ENOENT ? -ENOENT : -1;
+		rc = rc == ENOENT ? -ENOENT : -1;
+		goto out_free;
 	}
 
 	int status;
@@ -302,7 +331,11 @@ int exec_objcopy(const char *objcopy, const char *add_section,
 	pthread_sigmask(SIG_SETMASK, &orig, NULL);
 
 	if (status == -1 || !WIFEXITED(status))
-		return -1;
-
-	return WEXITSTATUS(status) == 0 ? 0 : -1;
+		rc = -1;
+	else
+		rc = WEXITSTATUS(status) == 0 ? 0 : -1;
+out_free:
+	free(argv);
+	free(cmd);
+	return rc;
 }
diff --git a/tests/btf_write_elf.sh b/tests/btf_write_elf.sh
index 64ce128..dc512e0 100755
--- a/tests/btf_write_elf.sh
+++ b/tests/btf_write_elf.sh
@@ -14,6 +14,9 @@
 #   exists from the first encode.  pahole opens the ELF with ELF_C_RDWR,
 #   overwrites the Elf_Data buffer in place, and calls elf_update() --
 #   no objcopy needed.  This is the "Existing .BTF section found" path.
+#
+# Path 1 is run again with options in LLVM_OBJCOPY, as kernel builds up to
+# v6.19 pass their $(OBJCOPY) command line there.
 
 . "$(dirname "$0")/test_lib.sh"
 outdir=$(make_tmpdir)
@@ -115,4 +118,35 @@ if [ "$has_bpftool" -eq 1 ]; then
 	info_log "BTF content valid after overwrite (elf_test found): ok"
 fi
 
+# --- Path 1 with options in LLVM_OBJCOPY ---
+# Kernel builds up to v6.19 run LLVM_OBJCOPY="${OBJCOPY}" pahole -J, and
+# $(OBJCOPY) is a command line that may carry options or trailing whitespace.
+# --preserve-dates keeps the old timestamp only if the option reaches objcopy.
+
+objcopy=${LLVM_OBJCOPY:-$OBJCOPY}
+if [ -z "$objcopy" ]; then
+	objcopy=objcopy
+	command -v llvm-objcopy > /dev/null 2>&1 && objcopy=llvm-objcopy
+fi
+args_obj="$outdir/write_elf_args_test.o"
+args_ref="$outdir/write_elf_args_test.ref"
+cp "$obj" "$args_obj"
+touch -t 200001010000 "$args_obj" "$args_ref"
+
+if ! LLVM_OBJCOPY="$objcopy --preserve-dates " pahole -J "$args_obj" 2>/dev/null; then
+	error_log "FAIL: pahole -J with options in LLVM_OBJCOPY failed (exit code != 0)"
+	test_fail
+fi
+
+if ! readelf -S "$args_obj" 2>/dev/null | grep -q '\.BTF[[:space:]]'; then
+	error_log "FAIL: .BTF section not found with options in LLVM_OBJCOPY"
+	test_fail
+fi
+
+if [ -n "$(find "$args_obj" -newer "$args_ref")" ]; then
+	error_log "FAIL: options in LLVM_OBJCOPY did not reach objcopy"
+	test_fail
+fi
+info_log "pahole -J with options in LLVM_OBJCOPY: ok"
+
 test_pass
-- 
2.43.0

