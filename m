Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E42BDC2F
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778909886; cv=none; b=Y5+eOjQ/NjFR58tNKUWyuJlcLYTiNBE0CMQKZueA8mCNTIp/DFEqnlo0gMNsgMmFbRaA4MAEw8ro1+HGc2dT6lKpWdW/9XuUO/FnB3pqHx/x18ichicINzLP/G7RAXD2OvrBxlaj4w5AKD2sjyUF+pkdJXpYS1DuMNctCBX5n6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778909886; c=relaxed/simple;
	bh=NeCNZpDy/wjHNqxVsv2RIvKmHgWjxmRCmaxHae/X4D0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=riIE89wRRkasCuos3BwT0WGZiQ1D9MiyRK72vQpJWwwLd8nHeIE7hmGJzTcZY40y/NPB/KWr/yTpRy2zxQtSBcBm60ti3pNNHoRT4V6snYy+QbpESYIlOeNk+yQs2qfFKCUX/hr+5KYnFuNCygHMdlGms4WD8ps0Nk5v4WX5gIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-69be75020ffso671247eaf.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778909883; x=1779514683;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyLryeyW13BLZ9d8MyaYUBYygJq8jduAUnGna0OnHu0=;
        b=XQYdYGPGvjfIygfObZY14ZG1Q9kRlz+FFTCgQZoHBHV9E0fkFDijR7HBgvlXA1HaGd
         663sf1jnZi6fT37iUEkX0asTqhv1XKQ3mesd+q2uxR/M2FKY+E1TS6mb0zBtsbIayIGy
         q2hpgnN3H2T3B34MusHCY7OscDlaAjGvnIbiPTFEDvtXREoQKXrnWyF5zQ3aLZto70L+
         R5zEEMsgHCN/ukF3jVApR8El4pQAv2/R2yi8maZhslq5ZLH3kieF/a0DPGTXteSU1ugA
         WgqMs/Y3zC+NnCm34ycLDnCi0dHzc4Njtt0VYR/Nrxp90W4DpBIG8gVMpgm2g2I/Np83
         7LuA==
X-Forwarded-Encrypted: i=1; AFNElJ+WHL1MIaEkSQYJgbTZwGhkE8S5t0imK+nOCL4ibl6B1BkRt/RW6jxKcfbbQ0p+eVbosxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTovebX63dAowOSsuL0PjYJy4ccq5H7QzaZv50Y4Csoid+nqDU
	Hkpt3jX9nuPwencaZOM4kGq3czvZL/wkKCjw8cty5FinctmMSEz35W2avTxXPfes1FvqxcYJROE
	MaRBHIhPUjvJ5phBLho5NM9q8FIwNYebNcpIBwh3xVnuM1xfh/q579nwhEEg=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:616:b0:696:72c4:5db1 with SMTP id
 006d021491bc7-69c942d22fbmr4598465eaf.14.1778909883572; Fri, 15 May 2026
 22:38:03 -0700 (PDT)
Date: Fri, 15 May 2026 22:38:03 -0700
In-Reply-To: <CACT4Y+b00++5Qys9hkZjMFEViLEnyt=wWt1rTNDkBT_OpXEygw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0802bb.170a0220.1ad1c0.0007.GAE@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_get_local_storage (2)
From: syzbot <syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com>
To: ameryhung@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, buaajxlj@163.com, daniel@iogearbox.net, 
	dvyukov@google.com, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	liangjie@lixiang.com, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy syz-execprog to VM: scp failed: failed to run ["scp" "-P" "4=
2200" "-F" "/dev/null" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "Identiti=
esOnly=3Dyes" "-o" "BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o"=
 "ConnectTimeout=3D10" "-v" "-O" "/syzkaller/jobs/linux/gopath/src/github.c=
om/google/syzkaller/bin/linux_amd64/syz-execprog" "root@localhost:/syz-exec=
prog"]: exit status 1



syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build789843944=3D/tmp/go-build -gno-record-gcc=
-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.26.0'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at d1b870e1003b
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3Dd1b870e1003b52891d2196c1e2ee42fe905010ba -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251128-125159"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3Dd1b870e1003b52891d2196c1e2ee42fe905010ba -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251128-125159"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd1b870e1003b52891d2196c1e2ee42fe905010ba -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251128-125159"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"d1b870e1003b52891d2196c1e2ee42fe90=
5010ba\"
/usr/bin/ld: /tmp/ccsZxb2m.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x386): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



Tested on:

commit:         5d691905 Linux 7.1-rc3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git v7.1-rc3
kernel config:  https://syzkaller.appspot.com/x/.config?x=3De090839556b4cb5=
8
dashboard link: https://syzkaller.appspot.com/bug?extid=3D4fe468a3f7fac86ea=
2c9
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-=
1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D147e98c85800=
00

