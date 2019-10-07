Return-Path: <SRS0=Z2SS=YA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5685ECE58C
	for <bpf@archiver.kernel.org>; Mon,  7 Oct 2019 16:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC90D20673
	for <bpf@archiver.kernel.org>; Mon,  7 Oct 2019 16:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gu3PXIhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfJGQVN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:21:13 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55136 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfJGQVN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Oct 2019 12:21:13 -0400
Received: by mail-pg1-f202.google.com with SMTP id m17so10425080pgh.21
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2019 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pFnmwsah0Tqm0ZFor0HGU7ultYypJGX8sasdZScFGlE=;
        b=Gu3PXIhNQzwfMK6sJW67/+E7pdy0OpbpcJEkgLsC12iHawxTITtnKA2Db/xV0sfNwp
         99enlXEswB7xJvOVjxGUyi/MVP9E341EFDuTI4qR1V+jL/4114gjKb71xanfxnyInryL
         kiXOqzk1DDA2KI+OfHq62scPYL2AL1NEtBww53YJ5VUIagXuER19zmeB7qc1CMCD5Ar/
         9jgGbt4XrX+qqSW0rqc7fivsgNMxRw5hayWoM/cjBhbiF5gK9C6BPrJS3Oe3MW+4i0LT
         yAnWTews4gc9KokAjM9Xd/Hksftgd98QEclClFylDInX+fWShcukwXEk6vR9aAqotUXN
         UB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pFnmwsah0Tqm0ZFor0HGU7ultYypJGX8sasdZScFGlE=;
        b=PdoKfyPMKHW8RKoB0oxcIFeV+z7/aNT4amZmA4ey7TburOxl4S7cwyUqig70Sdnymg
         UVTNBcibl29Sg1CmSAn3Wwe1SNduGKscRXx2ybMR69XkRH5d53i/5InY5+pmcO+x6w2o
         873408qD/hB8hd6nzBotecMkoDXq+SU+jlatcfYC2Fqn+wZCXOhWQY0gRp9kjyQLBwzF
         7h5mT2uCO1YWIrkQGfDGRtd0PFXM76+8hmrbCS1IssTNUGJrwUjTeZ1nWC2FZZhnE0Hq
         KW2b0RY5blDJIv2ARbhTnrzV2DwqDXYXIwL2PQVXN35fyfrCUU25ldgx4A/rJUYxjQYP
         Zzqg==
X-Gm-Message-State: APjAAAVo2iKfAfn1n/MZJy1a0Az7gqrmvtVPXMMgp0VuVVsy2VMrYkta
        g/Sai0eRZPh/6ZaQ+L96h5ANlKg=
X-Google-Smtp-Source: APXvYqwP0xh0SLlLotKZodHuCvC/HE0FfJO0egWt7J+F24MroFgUb5zHV1izBrUDEEa54w4j4swaFw0=
X-Received: by 2002:a63:d846:: with SMTP id k6mr31262942pgj.378.1570465270548;
 Mon, 07 Oct 2019 09:21:10 -0700 (PDT)
Date:   Mon,  7 Oct 2019 09:21:03 -0700
In-Reply-To: <20191007162103.39395-1-sdf@google.com>
Message-Id: <20191007162103.39395-3-sdf@google.com>
Mime-Version: 1.0
References: <20191007162103.39395-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: add test for BPF flow
 dissector in the root namespace
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure non-root namespaces get an error if root flow dissector is
attached.

Cc: Petar Penkov <ppenkov@google.com>
Acked-by: Song Liu <songliubraving@fb.com>

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/test_flow_dissector.sh      | 48 ++++++++++++++++---
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_flow_dissector.sh b/tools/testing/selftests/bpf/test_flow_dissector.sh
index d23d4da66b83..2c3a25d64faf 100755
--- a/tools/testing/selftests/bpf/test_flow_dissector.sh
+++ b/tools/testing/selftests/bpf/test_flow_dissector.sh
@@ -18,19 +18,55 @@ fi
 # this is the case and run it with in_netns.sh if it is being run in the root
 # namespace.
 if [[ -z $(ip netns identify $$) ]]; then
+	err=0
+	if bpftool="$(which bpftool)"; then
+		echo "Testing global flow dissector..."
+
+		$bpftool prog loadall ./bpf_flow.o /sys/fs/bpf/flow \
+			type flow_dissector
+
+		if ! unshare --net $bpftool prog attach pinned \
+			/sys/fs/bpf/flow/flow_dissector flow_dissector; then
+			echo "Unexpected unsuccessful attach in namespace" >&2
+			err=1
+		fi
+
+		$bpftool prog attach pinned /sys/fs/bpf/flow/flow_dissector \
+			flow_dissector
+
+		if unshare --net $bpftool prog attach pinned \
+			/sys/fs/bpf/flow/flow_dissector flow_dissector; then
+			echo "Unexpected successful attach in namespace" >&2
+			err=1
+		fi
+
+		if ! $bpftool prog detach pinned \
+			/sys/fs/bpf/flow/flow_dissector flow_dissector; then
+			echo "Failed to detach flow dissector" >&2
+			err=1
+		fi
+
+		rm -rf /sys/fs/bpf/flow
+	else
+		echo "Skipping root flow dissector test, bpftool not found" >&2
+	fi
+
+	# Run the rest of the tests in a net namespace.
 	../net/in_netns.sh "$0" "$@"
-	exit $?
-fi
+	err=$(( $err + $? ))
 
-# Determine selftest success via shell exit code
-exit_handler()
-{
-	if (( $? == 0 )); then
+	if (( $err == 0 )); then
 		echo "selftests: $TESTNAME [PASS]";
 	else
 		echo "selftests: $TESTNAME [FAILED]";
 	fi
 
+	exit $err
+fi
+
+# Determine selftest success via shell exit code
+exit_handler()
+{
 	set +e
 
 	# Cleanup
-- 
2.23.0.581.g78d2f28ef7-goog

