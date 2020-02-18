Return-Path: <SRS0=zGgN=4G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABD0C34047
	for <bpf@archiver.kernel.org>; Tue, 18 Feb 2020 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B0C24670
	for <bpf@archiver.kernel.org>; Tue, 18 Feb 2020 19:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBRTCo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:02:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:35758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgBRTCo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Feb 2020 14:02:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43D69ADE4;
        Tue, 18 Feb 2020 19:02:40 +0000 (UTC)
From:   Michal Rostecki <mrostecki@opensuse.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 5/6] bpftool: Update bash completion for "bpftool feature" command
Date:   Tue, 18 Feb 2020 20:02:22 +0100
Message-Id: <20200218190224.22508-6-mrostecki@opensuse.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218190224.22508-1-mrostecki@opensuse.org>
References: <20200218190224.22508-1-mrostecki@opensuse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update bash completion for "bpftool feature" command with information
about new arguments: "section", "filter_id" and "filter_out".

Signed-off-by: Michal Rostecki <mrostecki@opensuse.org>
---
 tools/bpf/bpftool/bash-completion/bpftool | 32 +++++++++++++++++------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 754d8395e451..ff8ac9bebdda 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -981,14 +981,30 @@ _bpftool()
         feature)
             case $command in
                 probe)
-                    [[ $prev == "prefix" ]] && return 0
-                    if _bpftool_search_list 'macros'; then
-                        COMPREPLY+=( $( compgen -W 'prefix' -- "$cur" ) )
-                    else
-                        COMPREPLY+=( $( compgen -W 'macros' -- "$cur" ) )
-                    fi
-                    _bpftool_one_of_list 'kernel dev'
-                    return 0
+                    case $prev in
+                        $command)
+                            COMPREPLY+=( $( compgen -W 'kernel dev section filter_in filter_out macros' -- \
+                                "$cur" ) )
+                            return 0
+                            ;;
+                        section)
+                            COMPREPLY+=( $( compgen -W 'system_config syscall_config program_types map_types helpers misc' -- \
+                                "$cur" ) )
+                            return 0
+                            ;;
+                        filter_in|filter_out|prefix)
+                            return 0
+                            ;;
+                        macros)
+                            COMPREPLY+=( $( compgen -W 'prefix' -- "$cur" ) )
+                            return 0
+                            ;;
+                        *)
+                            _bpftool_one_of_list 'kernel dev'
+                            _bpftool_once_attr 'section filter_in filter_out macros'
+                            return 0
+                            ;;
+                    esac
                     ;;
                 *)
                     [[ $prev == $object ]] && \
-- 
2.25.0

