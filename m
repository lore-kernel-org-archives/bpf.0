Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5C314D37
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621513; cv=pass; b=GSmus2YMKGxz1htzDuFrqM7woU86P2fH89E1W3LX2AofYl8XDb428tPls5c3kK+sWa/7F2l7O5gSGfbXjgiCHUa2bjhjghRhGmIdhlJeyqNLbmYaH/o2R8wIV3pcXVe1dRnvyBhazwZ/6vc8xfi1HTYyD2yjLx8xOBGQFt/CWek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621513; c=relaxed/simple;
	bh=L0KvSDN5YMgJEa1mOF3k46aRAnm/3tmb/hvbzs6p/e8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=prOuSa7hfZLuUWODjlGhsWG1Ppk5vM2wG6bdE7uyV6AHPvcMSGZjxJTT22HhK/i7bVdG8C2g3MsAW+i0SEXr3FFXRtoHc8G4LpzEKiS5Zg+DSPzt9o4Xdhg/9aI/EKIAVtAT+2gIa9VxiYfm7PJNROyHh0u4cDPRH0CxEmPncdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bU2BthHw; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU2BthHw"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3870cbd6c40so107598021fa.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 02:51:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772621511; cv=none;
        d=google.com; s=arc-20240605;
        b=LaGecMa7Gg3b6bJaQySqz9RFOcUyvQGWe433B1+3lvbiuJM/RFcUDJSH+qC9nklRks
         l3E8uqhK83I+ziWz2Sh1Ga29GYZTQphp1M+AF1jXROsLhoiFHbiJkaaKU/XDY0N63WG0
         kLsAKHjGBtGV2wYw8aSDpm6s0k07QTCO2+jIyOvcKLhIOEdyid1+l+AbZrJKipltmNQx
         3Z/nsmWGfXzKABypkaJo9w7/u/28xVO8trbvhR60QARFr7coEeAY6lDAMUeliOGfAgL9
         s4eJXOmNRVePgqs90hs0KvYkWdqoDO3+Zju5mJIsNRp4il+ewVSQ+yDBpmQVeJ7Vwy5H
         gPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AZvKF3gSYTbPT4SlKBZ7fQjgKlABzp9L6yM4JYTNPBk=;
        fh=YSs3wVOwLpYXHDVTQOQhpuQf9sYEKrNgSkySr3HbMXY=;
        b=YPYRNyxuPt/wW8VKZIHlxCZlihM8hi7DNvBt02yD0+C6tjXAu8vwO67C9xlCJwDteW
         6hbv3FovEsBPYYqT0TcUcJMJfsUgxhRsH86I4jgTXzAFgOfeeH0s3mPTZhGKOMzIk6XB
         x4NfI7tnCICqnj3PdF/iP/9WLZPgugavwILF8qXxwxHzUhdMVaZJ/32wH88tG1eQQCCs
         WbFzMkmyAl9E93rAsraSa9UQvigBu2dfiCkrJ0NmHoHbdqnBcxdUUaqTVmJE/e36OgX/
         CCjuNuTauP2svpecjoeCpVIF9L/cvGIaXQuWDNHF4Qh490m/flvIG4Lvb35QFMOhP3in
         k85w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772621511; x=1773226311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AZvKF3gSYTbPT4SlKBZ7fQjgKlABzp9L6yM4JYTNPBk=;
        b=bU2BthHwCRbeyJEEHcK7Iwsbk+FdqTF2qk1zUIQRNeI6x7a9wOarITbuOYbORHE5oQ
         BN1LjCv4Qpl0J6gbeNHWpP9eCNBkeMJ+NP9z9NgwofwT4hm6azbgoBjWB+jB9V0Txtoi
         SCrXt7ExqurcW5m0ADmIjYTXVRzcj7SfK3vNIUdfF/+Tyvig6uXMhvno6ixRNjDGfW1F
         tf6XxwpEIppj9+ccEIuU8IzZraGEmRf9nwA5N6FIHSkiHQa8QJHEPjyKEeWPrTZWd8yD
         7OLyhONTcb7yKcKwTMQHPb3lGDgHWL4yHln4sp/2mtkGoyajgdNtKyhE9HQBf+SRsZD7
         MTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772621511; x=1773226311;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZvKF3gSYTbPT4SlKBZ7fQjgKlABzp9L6yM4JYTNPBk=;
        b=Y1bhu/sTr/1ItZitXUX425Jgr4ukQ8HbIsilLUu0OY8KxqPtwdo8bokv9cQ48p0FmS
         bz2Fa4gpPC2AzB8sbG8heO9uif+TWiY5jbB2u/WqurqHlJgv1WvizlKRpfoZbUNo0Ym/
         HlTAAxr9cmhUFrtAr18EB7qLYPSy8QS+WhS/pzrYaUS7FPz+N5D9MVK8W0PtR43nHj0p
         hln011d33oQHPeAMItX6dnEHcFUr5eXf6H3Yr+KTZURs9E8i9OLujQZCB27EY8Qe5vzs
         KxsvKNuWp5EBxj0RyeMbm2EeuC6GfJQWSC271wOJV63v0pxklt747C5DNriRqlbe100a
         g2dw==
X-Forwarded-Encrypted: i=1; AJvYcCWecLDKmnZRHEUcHxg14oIy1Kfx+mrWBdO770LEip2QsictGzGVkceFCtEwxlLaxHdFrts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZzyqPe3Wor8AOS78caYoCFKLymZEvhDL6nTFUIkDDG45VRvfT
	XItxsnIJg50SFftBODJLf+6wB4rfuCxiJLR80HdeAYzT3Q4tWnzDsBrflhkCjJUbhEcvp3Idw2y
	k/JQ1INvH0f08ir8MbxA2j5mZlLdSTRo=
X-Gm-Gg: ATEYQzxONsngOOWxbO/2T96WqnFb+N/eP9IAeADFgwL0r7OGZwOlUvA5kobWr7ALtzb
	t5zdkQkbGVh4X4P8UsHLYrS82fQeE9TaD43cWkQUHq1/kNEthy0HW8Ab+H9Fz624YuX+b3rMGVy
	/pgxxvBC3EOd8wGFvyq8y7v2ZDwoczWzhww69Gpj91KVNK+T4GTowWC81rMUKAR0jNM9dTYkuUH
	ieu3KD+P0Wuu44ifL93vFJGENrTW6USg/z7A15oALHy7DDyZhiiqOA9LGcZFvwBIPtMJXdT1oJO
	+m+blTX+P2fx7FJ3lw==
X-Received: by 2002:a05:651c:1550:b0:385:f8c8:b3f with SMTP id
 38308e7fff4ca-38a2c5b9491mr13522801fa.25.1772621510334; Wed, 04 Mar 2026
 02:51:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Max Ver <dudududumaxver@gmail.com>
Date: Wed, 4 Mar 2026 18:51:38 +0800
X-Gm-Features: AaiRm50GaV7PmYiAQtjK3ldkIooz443XUg3Z9bCG6AZjmeJAobyVzQ7j4vsiMak
Message-ID: <CABjJbFJO+p3jA1r0gjUZrCepQb1Fab3kqxYhc_PSfoqo21ypeQ@mail.gmail.com>
Subject: Process killed by seccomp looks live by tracer
To: linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"

I was using ptrace to trace a tracee status, using
`PTRACE_GET_SYSCALL_INFO` and `PTRACE_SYSCALL`
to get its syscall arguments and results. When a tracee killed by its
seccomp, the tracer can't know immediately,
instead, the `PTRACE_GET_SYSCALL_INFO` tell tracer that tracee exit
with no error. The syscall wasn't actually
executed, it was captured by seccomp, even the tracee was killed by seccomp.

Here is a poc explaining what I said.
I was expecting to aware the death of tracee at the fourth
`PTRACE_GET_SYSCALL_INFO`,
at least `PTRACE_GET_SYSCALL_INFO` should tell that the syscall
failed, or get some different message from waitpid.
But the result are below. Tracer can only get the death of tracee at
the fifth loop.

---
Start tracing child
entry
exit ok
entry
exit ok
get_syscall_info: No such process
---
// poc file
#include <linux/audit.h>
#include <linux/filter.h>
#include <linux/seccomp.h>
#include <string.h>
#include <sys/ptrace.h>
#include <linux/ptrace.h>
#include <signal.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/prctl.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <threads.h>
#include <unistd.h>

void
child ()
{
  if (prctl (PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
    {
      perror ("prctl");
      exit (1);
    }
  ptrace (PTRACE_TRACEME, 0, 0, 0);
  raise (SIGSTOP);

  struct sock_filter filter[] = {
    BPF_STMT (BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
  };

  struct sock_fprog prog = {
    .len = 1,
    .filter = filter,
  };

  if (syscall (SYS_seccomp, SECCOMP_SET_MODE_FILTER, 0, &prog))
    {
      perror ("seccomp");
      exit (1);
    }
  write (1, "a", 1);
}

void
get_child_info (pid_t pid)
{
  int status;

  struct ptrace_syscall_info info;
  memset (&info, 0, sizeof (info));
  ptrace (PTRACE_SYSCALL, pid, 0, 0);
  if ((waitpid (pid, &status, 0) == -1) || WIFEXITED (status))
    {
      puts ("child exit");
      exit (1);
    }
  if (ptrace (PTRACE_GET_SYSCALL_INFO, pid,
              sizeof (struct ptrace_syscall_info), &info)
      == -1)
    {
      perror ("get_syscall_info");
      exit (1);
    }

  if (info.op == PTRACE_SYSCALL_INFO_ENTRY)
    puts ("entry");
  else if (info.op == PTRACE_SYSCALL_INFO_EXIT)
    puts (info.exit.is_error ? "exit with err" : "exit ok");
  else if (info.op == PTRACE_SYSCALL_INFO_NONE)
    puts ("none");
  else if (info.op == PTRACE_SYSCALL_INFO_SECCOMP)
    puts ("seccomp");
  else
    printf ("%d\n", info.op);
}

void
parent (pid_t pid)
{
  int status;
  waitpid (pid, &status, 0);
  puts ("Start tracing child");

  if (ptrace (PTRACE_SETOPTIONS, pid, 0, PTRACE_O_TRACESYSGOOD) == -1)
    exit (1);
  while (1)
    get_child_info (pid);
}

int
main ()
{
  pid_t pid = fork ();
  if (pid == 0)
    child ();
  else
    parent (pid);
}
